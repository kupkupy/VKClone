//
//  File.swift
//  RealProject
//
//  Created by Tanya on 05.05.2022.
//

import Foundation

// MARK: - FriendsResponse
struct FriendsResponse: Codable {
    let response: FriendsItem
}

// MARK: - Response
struct FriendsItem: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let online: Int
    let city: City?
    let canAccessClosed: Bool?
    let id: Int
    let photo100: String
    let lastName, trackCode: String
    let isClosed: Bool?
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case online, city
        case canAccessClosed = "can_access_closed"
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

