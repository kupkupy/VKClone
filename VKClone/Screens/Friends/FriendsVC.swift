//
//  FriendsViewController.swift
//  RealProject
//
//  Created by Tanya on 05.05.2022.
//

import UIKit

final class FriendsVC: UIViewController, FriendVCDelegate {
    
    let friendsAPI = FriendsAPI()
    
    var tableViewDataSource = FriendTableViewDataSource()
    var tableViewDelegate: FriendTableViewDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = tableViewDataSource
        tableView.prefetchDataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.refreshControl = refreshControl
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Друзья"
        
        self.tableViewDelegate = FriendTableViewDelegate(withDelegate: self)
        
        setupViews()
        setupConstraints()
        
        fetchFriends()
    }
    
    func fetchFriends() {
        
        friendsAPI.getFriends(offset: 0) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let friends):
                self.tableViewDataSource.updateFriends(friends)
                //self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()

            #warning("какой алерт контроллер нужно добавить?")
            case .failure(let error):
                print("Вывод на AlertController", error)
            }
        }
    }
    
    func selectedCell(row: Int) {
        print("ROW: \(row)")
        let friend = self.tableViewDataSource.dataSource[row]

        let groupVC = GroupVC()
        groupVC.friendID = friend.id
        
        navigationController?.pushViewController(groupVC, animated: true)
    }
    
    func setupViews() {
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
    
    @objc private func pullToRefreshAction(sender: UIRefreshControl) {
        #warning("Обновляется только несколько строк")
        fetchFriends()
        sender.endRefreshing()
    }
}

