//
//  UserPhoto.swift
//  RealProject
//
//  Created by Tanya on 25.05.2022.
//

import Foundation

//MARK: - ----- photos.getAll -----

// MARK: - PhotoResponse
struct PhotoResponse: Codable {
    let response: PhotoItem
}

// MARK: - Response
struct PhotoItem: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Item
struct Photo: Codable {
    let albumID: Int
    let reposts: Reposts?
    let postID: Int?
    let id, date: Int
    let text: String
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let likes: Likes?
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case reposts
        case postID = "post_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case likes, lat, long
    }
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
}


//MARK: - ----- photos.get ------

//// MARK: - PhotoResponse
//struct PhotoResponse: Codable {
//    let response: PhotoItem
//}
//
//// MARK: - Response
//struct PhotoItem: Codable {
//    let count: Int
//    let items: [Photo]
//}
//
//// MARK: - Item
//struct Photo: Codable {
//    let id: Int
//    let comments: Comments
//    let likes: Likes
//    let reposts, tags: Comments
//    let date, ownerID: Int
//    let text: String
//    let sizes: [Size]
//    let hasTags: Bool
//    let albumID, canComment: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id, comments, likes, reposts, tags, date
//        case ownerID = "owner_id"
//        case text, sizes
//        case hasTags = "has_tags"
//        case albumID = "album_id"
//        case canComment = "can_comment"
//    }
//}
//
//// MARK: - Comments
//struct Comments: Codable {
//    let count: Int
//}
//
//// MARK: - Likes
//struct Likes: Codable {
//    let count, userLikes: Int
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case userLikes = "user_likes"
//    }
//}
//
//// MARK: - Size
//struct Size: Codable {
//    let width, height: Int
//    let url: String
//    let type: String
//}
