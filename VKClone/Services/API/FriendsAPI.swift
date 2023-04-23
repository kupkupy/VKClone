//
//  FriendsAPI.swift
//  RealProject
//
//  Created by Tanya on 05.05.2022.
//

import Foundation
import Alamofire

//Services выполняет какую-либо бизнес-логику.
//В FriendsAPI будут хранится все запросы к друзьям.

//GET - получение
//POST - создание
//PUT/PATCH - изменение
//DELETE - удаление

final class FriendsAPI {
    
    //https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
    
    //let baseURL = "https://api.vk.com/method"
    
    func getFriends(offset: Int = 0, completion: @escaping(Result<[Friend], Error>)->()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.shared.userID ?? 0)),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "fields", value: "photo_100, city, online"),
            URLQueryItem(name: "fields", value: "photo_100, city, online"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: urlComponents.url!)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    print("Status: \(response.statusCode)")
                    break
                case 400..<500:
                    print("Client Error")
                    completion(.failure(AppError.clientError))
                
                case 500..<600:
                    print("Server Error")
                    completion(.failure(AppError.serverError))
                    
                default:
                    print("Status: \(response.statusCode)")
                }
            }
            
            guard let jsonData = data else { return }
            
            do {
                let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: jsonData)
                let friends = friendsResponse.response.items
                
                //Отправка задачи на очередь в главный поток
                //print(Thread.current)
                DispatchQueue.main.async {
                    completion(.success(friends))
                }
            } catch {
                print(error)
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
}
    
    //MARK: -  Этот же запрос с помощью Alamofire
    
//        let method = "/friends.get"
//        let url = baseURL + method
//        let params: [String: Any] = [
//            "user_id": Session.shared.userID,
//            "order": "name",
//            "offset": offset,
//            "count": "50",
//            "fields": "photo_100, city, online",
//            "access_token": Session.shared.token,
//            "v": "5.131"
//        ]
    
    //        AF.request(url, method: .get, parameters: params).responseData { responseData in
    //
    //            guard let jsonData = responseData.data else { return }
    //
    //            do {
    //                let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: jsonData)
    //                let friends = friendsResponse.response.items
    //                completion(friends)
    //            } catch {
    //                print(error)
    //            }
    //        }
    
