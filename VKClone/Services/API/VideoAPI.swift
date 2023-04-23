//
//  VideoAPI.swift
//  vk-tanya
//
//  Created by Tanya on 22.08.2022.
//

import Foundation

final class VideoAPI {
    
    func fetchVideos(offset: Int = 0, completion: @escaping(Result<[Video], Error>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/video.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userID!)"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        let session = URLSession(configuration: .default)
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        
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
                    //completion(.failure(AppError.clientError))
                
                case 500..<600:
                    print("Server Error")
                    //completion(.failure(AppError.serverError))
                    
                default:
                    print("Status: \(response.statusCode)")
                }
            }
            
            guard let jsonData = data else { return }

            do {
                let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: jsonData)
                let videos = videoResponse.response.items
                
                DispatchQueue.main.async {
                    completion(.success(videos))
                }

            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
   
    
    
}
