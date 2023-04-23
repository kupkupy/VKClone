//
//  InfoViewController.swift
//  RealProject
//
//  Created by Tanya on 27.05.2022.
//

import UIKit
import SDWebImage
import SkeletonView
import SnapKit

//Рефакторинг - SnapKit, Async Request, Request Chain

enum ProfileCellType: Int, CaseIterable {
    case info
    case photos
}

final class ProfileVC: UIViewController {
    
    private var profileHeaderView = ProfileHeaderView()
    private let profileAPI = ProfileAPI()
    private var profileData: [Profile] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.register(ProfileInfoCell.self, forCellReuseIdentifier: ProfileInfoCell.identifier)
        tableView.register(ProfilePhotosCell.self, forCellReuseIdentifier: ProfilePhotosCell.identifier)
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfoAndStatus()

        setupViews()
        setupConstraints()
        
        
    }
    
    private func getInfoAndStatus() {
        
        Task {
            do {
                let profile = try await profileAPI.getInfo()
                let status = try await profileAPI.getStatus()
                
                self.profileData = [profile]
                
                self.profileHeaderView.setup(self.profileData)
                self.profileHeaderView.statusLabel.text = status
                
                self.view.isSkeletonable = false
                
                self.tableView.reloadData()
                self.turnOffAndReload()
                
            } catch {
                print("Отобразить на Alert", error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        turnOnSkeletons()
    }
    
    //MARK: - Private

    private func setupViews() {
        
        view.backgroundColor = .white
        view.isSkeletonable = true
        title = "Профиль"
        
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(showNotificationScreen))
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().offset(0)
        }
    }
    
    //MARK: - Skeleton logic
    
    private func turnOffAndReload() {
        tableView.hideSkeleton()
        tableView.isSkeletonable = false

        profileHeaderView.hideSkeleton()
        profileHeaderView.isSkeletonable = false
        
        profileHeaderView.layoutIfNeeded()
        
        view.layoutIfNeeded()
    }
    
    private func turnOnSkeletons() {
        tableView.isSkeletonable = true
        tableView.visibleCells.forEach { $0.showSkeleton() }
    }
    
    //MARK: - Actions
    @objc
    func showNotificationScreen() {
        let notificationVC = NotificationVC()
        self.navigationController?.present(notificationVC, animated: true)
    }
    
    @objc private func pullToRefreshAction() {
        refreshControl.beginRefreshing()
        refreshControl.endRefreshing()
    }
    
    func showPhotoScreen() {
        let photoVC = PhotoVC()
        navigationController?.pushViewController(photoVC, animated: true)
    }
}

//SkeletonTableViewDataSource наследуется от UITableViewDataSource, поэтому UITableViewDataSource можно не писать
extension ProfileVC: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = ProfileCellType(rawValue: indexPath.row) else { return UITableViewCell()
        }
        
        switch cellType {
        case .info:
            
            let profileInfoCell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoCell.identifier, for: indexPath) as! ProfileInfoCell
            
            for item in self.profileData {
                profileInfoCell.configure(item)
            }
                        
            return profileInfoCell
            
        case .photos:
            
            let profilePhotosCell = tableView.dequeueReusableCell(withIdentifier: ProfilePhotosCell.identifier, for: indexPath) as! ProfilePhotosCell
            profilePhotosCell.configure(profileData)
            
            #warning("Фотографии как загрузить?")
            
            return profilePhotosCell
            
        default:
            return UITableViewCell()
            
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        #warning("чтобы обновились данные в хэдере нужно вернуть экземпляр хэдера в методе viewForHeaderInSection, а не просто класс хэдера?")
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cellType = ProfileCellType(rawValue: indexPath.row) else { return }
        
        switch cellType {
            
        case .info:
            print("Нажали на info")
        case .photos:
            showPhotoScreen()
        }

    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        
        guard let cellType = ProfileCellType(rawValue: indexPath.row) else { return "" }
        
        switch cellType {
    
        case .info:
            return ProfileInfoCell.identifier
        case .photos:
            return ProfilePhotosCell.identifier
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        return profileHeaderView.identifier
    }
}
   
