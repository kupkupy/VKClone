//
//  File.swift
//  RealProject
//
//  Created by Tanya on 17.05.2022.
//

import Foundation
import Alamofire

extension String {
    var isNull: Bool {
        return (self == "0") ? true : false
    }
}

final class GroupsAPI {
    
    let baseURL = "https://api.vk.com/method"
    
    func getGroups(_ friendId: Int, offset: Int = 0, completion: @escaping(Result<[Group], Error>)->()) {
        
        //Network Error
        
        var candidatId: String = String(friendId)
        //print(candidatId, type(of: candidatId))
        if candidatId.isNull || candidatId.isEmpty {
            candidatId = String(Session.shared.userID ?? 0)
        }

        let method = "/groups.get"
        let url = baseURL + method
        
        let params: [String: String] = [
            "user_id": candidatId,
            "extended": "1",
            "count": "50",
            "offset": "\(offset)",
            "fields": "name, photo_100, screen_name, members_count, status, description", 
            "access_token": Session.shared.token,
            "v": "5.131"
        ]
        print(params)
       
        AF.request(url, method: .get, parameters: params).responseData { responseData in
            
            //Status code 500-е - Server Error
            //Status code 400-е - Client Error
            
            guard let jsonData = responseData.data else { return }
            
            print(jsonData.prettyJSON as Any)
            
            do {
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: jsonData)
                let groups = groupsResponse.response.items
                
                print(Thread.current)
                completion(.success(groups))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
}
