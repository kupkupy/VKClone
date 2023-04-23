//
//  MainTabBarController.swift
//  RealProject
//
//  Created by Tanya on 20.05.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    private enum MainTabBarItem {
        case friends
        //case photos
        case groups
        case profile
        case video
        
        var title: String {
            switch self {
            case .friends:
                return "Друзья"
//            case .photos:
//                return "Фотографии"
            case .groups:
                return "Сообщества"
            case .profile:
                return "Профиль"
            case .video:
                return "Видеозаписи"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .friends:
                return UIImage(systemName: "person.2")
//            case .photos:
//                return UIImage(systemName: "photo.on.rectangle.angled")
            case .groups:
                return UIImage(systemName: "person.3")
            case .profile:
                return UIImage(systemName: "person")
            case .video:
                return UIImage(systemName: "video")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let items: [MainTabBarItem] = [.profile, .friends, .groups, .video] //.photos
        
        self.viewControllers = items.map ({ item in
            switch item {
            case .friends:
                return UINavigationController(rootViewController: FriendsVC())
//            case .photos:
//                return UINavigationController(rootViewController: PhotoVC())
            case .groups:
                return UINavigationController(rootViewController: GroupVC())
            case .profile:
                return UINavigationController(rootViewController: ProfileVC())
            case .video:
                return UINavigationController(rootViewController: VideoVC())
            }
        })
        
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }
}
