//
//  GroupeViewController.swift
//  RealProject
//
//  Created by Tanya on 17.05.2022.
//

import UIKit
import BLTNBoard

final class GroupVC: UIViewController {

    let groupsAPI = GroupsAPI()
    
    var viewModel = GroupViewModel()
    
    // Открытая переменная
    lazy var friendID: Int = 0 {
        didSet {
            viewModel.friendID = friendID
        }
    }
    
    private var boardManager: BLTNItemManager?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        viewModel.fetchGroups(offset: 0) {
            self.tableView.reloadData()
        }
    }
           
    func setupViews() {
        title = "Cообщества"
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func pullToRefreshAction() {
        refreshControl.beginRefreshing()
        
        viewModel.fetchGroups {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

extension GroupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.groups.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell
        let group = viewModel.groups[indexPath.row]
        cell.configureGroup(group)
        return cell
    }
}

extension GroupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = viewModel.groups[indexPath.row]
        boardManager = {
            let item = BLTNPageItem(title: group.name ?? "")
            item.image = UIImage(named: String(group.photo100))
            item.descriptionText = group.itemDescription
            return BLTNItemManager(rootItem: item)
        }()

        boardManager!.showBulletin(above: self)
    }
}

extension GroupVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row >= viewModel.groups.count - 5 {
                if !viewModel.isLoading {
                    viewModel.isLoading = true
                    
                    groupsAPI.getGroups(friendID, offset: viewModel.offset) { [weak self] result in
                        
                        guard let self = self else { return }
                        
                        switch result {
                        case .success(let groups):
                            
                            //Защита от дубликатов
                            for group in groups {
                                let dublicate = self.viewModel.groups.first(where: { $0.id == group.id } )
                                
                                if dublicate == nil {
                                    self.viewModel.groups.append(group)
                                }
                            }
                            
                            tableView.reloadData()
                        case .failure(let error):
                            print("Error", error)
                        }
                        
                        self.viewModel.isLoading = false
                    }
                }
            }
        }
    }
}



//MARK: - обычный метод показа bottomSheet:
////        let descriptionVC = DescriptionVC()
////        descriptionVC.groupDescriptionLabel.text = group.itemDescription
//
////        descriptionText = group.itemDescription
////        descriptionTitle = group.name
////        groupImage = UIImage(named: String(group.photo100))
////        #warning("Title не отображается и bottomSheet не скроллится")
////        descriptionVC.title = group.name
//
////        if let sheet = descriptionVC.sheetPresentationController {
////            sheet.detents = [.medium()]
////            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
////            sheet.preferredCornerRadius = 24
////            sheet.prefersGrabberVisible = true
////
////        }
//        //present(descriptionVC, animated: true)
//
//
//        //MARK: - показ с помощью библиотеки BLTNBoard
//        boardManager = {
//            let item = BLTNPageItem(title: group.name)
//            item.image = UIImage(named: String(group.photo100))
//            item.descriptionText = group.itemDescription
//    //        item.actionHandler = { _ in
//    //            GroupVC.didTapBoardContinue()
//    //        }
//            return BLTNItemManager(rootItem: item)
//        }()
//
//        boardManager!.showBulletin(above: self)
//    }

