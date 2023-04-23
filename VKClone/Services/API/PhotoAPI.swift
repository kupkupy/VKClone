//
//  PhotoAPI.swift
//  RealProject
//
//  Created by Tanya on 25.05.2022.
//

import Foundation

final class PhotoAPI {
    
// MARK: - photos.getAll
    
    func getPhoto(offset: Int = 0, completion: @escaping(Result<[Photo], Error>)->()) {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/photos.getAll"
    
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: String(Session.shared.userID ?? 0)),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "count", value: "50"),
                URLQueryItem(name: "no_service_albums", value: "0"),
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
    
            let session = URLSession(configuration: .default)
    
            let request = URLRequest(url: urlComponents.url!)
    
            let task = session.dataTask(with: request) { data, response, error in
    
                if let error = error {
                    print(error.localizedDescription)
                    return
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
    
                do {
                    let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: jsonData)
                    let photos = photoResponse.response.items
                    print(Thread.current)
                    DispatchQueue.main.async {
                        completion(.success(photos))
                    }
                } catch {
                    print(error)
                    completion(.failure(error))
                }
    
            }
    
            task.resume()
        }
    
    func getFriendPhoto(_ friendId: Int, completion: @escaping([Photo])->()) {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/photos.getAll"
        
            let stringFriendId = String(friendId)
    
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: stringFriendId),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "count", value: "50"),
                URLQueryItem(name: "no_service_albums", value: "0"),
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
    
            let session = URLSession(configuration: .default)
    
            let request = URLRequest(url: urlComponents.url!)
    
            let task = session.dataTask(with: request) { data, response, error in
    
                if let error = error {
                    print(error.localizedDescription)
                    return
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
    
                do {
                    let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: jsonData)
                    let photos = photoResponse.response.items
                    completion(photos)
                } catch {
                    print(error)
                }
            }
    
            task.resume()
        }
}


// MARK: - photos.get - вытаскивает сохраненные фото (именно сохраненные)
    
//    func getPhoto(completion: @escaping([Photo])->()) {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/photos.get"
//
//        urlComponents.queryItems = [
//            URLQueryItem(name: "owner_id", value: Session.shared.userID),
//            URLQueryItem(name: "album_id", value: "saved"),
//            URLQueryItem(name: "extended", value: "1"),
//            URLQueryItem(name: "feed_type", value: "photo"),
//            URLQueryItem(name: "count", value: "50"),
//            URLQueryItem(name: "access_token", value: Session.shared.token),
//            URLQueryItem(name: "v", value: "5.131")
//        ]
//
//        let session = URLSession(configuration: .default)
//
//        let request = URLRequest(url: urlComponents.url!)
//
//        let task = session.dataTask(with: request) { data, response, error in
//
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            if let response = response as? HTTPURLResponse {
//                switch response.statusCode {
//                case 200 ... 300:
//                    print("Status: \(response.statusCode)")
//                    break
//                default:
//                    print("Status: \(response.statusCode)")
//                }
//            }
//
//            guard let jsonData = data else { return }
//
//            do {
//                let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: jsonData)
//                let photos = photoResponse.response.items
//                completion(photos)
//            } catch {
//                print(error)
//            }
//
//        }
//
//        task.resume()
//    }
