//
//  GroupDataSource.swift
//  vk-tanya
//
//  Created by Tanya on 06.07.2022.
//

import UIKit

final class GroupViewModel {

    let groupAPI = GroupsAPI()
    
    lazy var groups: [Group] = [] {
        didSet {
            offset = groups.count
        }
    }
    
    var friendID: Int = 0
    var offset: Int = 0
    
    var isLoading = false
    
    func fetchGroups(offset: Int = 0, completion: @escaping () -> ()) {
        groupAPI.getGroups(friendID, offset: offset) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success(let groups):
                if offset == 0 {
                    self.groups = groups
                    completion()
                    return
                }
                
                self.groups.append(contentsOf: groups)
                completion()
            case .failure(let error):
                print(error)
                #warning("Дописать алерт при получении ошибки")
            }
        }
    }
}
