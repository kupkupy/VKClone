//
//  TableView.swift
//  RealProject
//
//  Created by Tanya on 02.06.2022.
//

import UIKit

class FriendTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    let friendsAPI = FriendsAPI()
    
    var dataSource: [Friend] = [] {
        didSet {
            offset = dataSource.count
        }
    }
    
    var offset: Int = 0
    
    var isLoading = false
    
    func updateFriends(_ friends: [Friend]) {
        self.dataSource = friends
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as! FriendCell
        let friend = dataSource[indexPath.row]
        
        cell.configureFriends(friend)
        
        let groupVC = GroupVC()
        groupVC.friendID = friend.id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            
            if indexPath.row >= self.dataSource.count - 5 {
                
                if !isLoading {
                    isLoading = true
                    
                    friendsAPI.getFriends(offset: offset) { [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success(let friends):
                            
                            // Защита от дубликатов
                            for friend in friends {
                                let duplicate = self.dataSource.first(where: { $0.id == friend.id })
                                if duplicate == nil {
                                    self.dataSource.append(friend)
                                }
                            }
                            
                            tableView.reloadData()
                            
                        case .failure(let error):
                            print("Error", error)
                        }
                        
                        self.isLoading = false
                    }
                }
                
            }
        }
    }
}
