//
//  WallAPI.swift
//  RealProject
//
//  Created by Tanya on 14.06.2022.
//

import Foundation

final class WallAPI {
    
    func getWall() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/wall.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: String(Session.shared.userID ?? 0)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "20")
            //URLQueryItem(name: "extended", value: "1"),
            //URLQueryItem(name: "fields", value: "first_name, last_name, photo_100")
        ]
            
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: urlComponents.url!)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200 ... 300:
                    print("Status: \(response.statusCode)")
                    break
                default:
                    print("Status: \(response.statusCode)")
                }
            }
            
            guard let jsonData = data else { return }
            print(jsonData.prettyJSON)
        }
        task.resume()
        
    }
    
}
