//
//  SelfInfo.swift
//  RealProject
//
//  Created by Tanya on 27.05.2022.
//

import Foundation

final class ProfileAPI {
    
    func getInfo() async throws -> Profile {
        
        let profile: Profile = try await withCheckedThrowingContinuation({ continuation in
            
            getInfo { result in
                switch result {
                    
                case .success(let profile):
                    continuation.resume(returning: profile)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        
        return profile
    }
    
    func getStatus() async throws -> String {
        
        let status: String = try await withCheckedThrowingContinuation({ continuation in
            
            getStatus { result in
                switch result {
                    
                case .success(let status):
                    continuation.resume(returning: status)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        
        return status
    }
    
    func getInfo(completion: @escaping(Result<Profile, Error>)->()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"

        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: String(Session.shared.userID ?? 0)),
            URLQueryItem(name: "fields", value: "bdate, city, country, contacts, counters, crop_photo, education, photo_100"),
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
                let infoResponse = try JSONDecoder().decode(ProfileResponse.self, from: jsonData)
                guard let info = infoResponse.response.first else { return }
                
                //Отправка задачи на очередь в главный поток
                print(Thread.current)
                DispatchQueue.main.async {
                    completion(.success(info))
                }
            } catch {
                print(error)
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    func getStatus(completion: @escaping(Result<String, Error>)->()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/status.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.shared.userID ?? 0)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131"),
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
            
            do {
                let statusResponse = try JSONDecoder().decode(StatusResponse.self, from: jsonData)
                let status = statusResponse.response.text
                completion(.success(status))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
