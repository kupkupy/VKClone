//
//  Group.swift
//  RealProject
//
//  Created by Tanya on 17.05.2022.
//

import Foundation

// MARK: - GroupsResponse
struct GroupsResponse: Codable {
    let response: GroupsItems
}

// MARK: - Response
struct GroupsItems: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let id: Int
    let itemDescription, screenName: String?
    let isClosed, isAdvertiser: Int?
    let type: String
    let membersCount, isMember, isAdmin: Int?
    let photo100: String
    let status, name: String?
    let adminLevel: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case itemDescription = "description"
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case isAdvertiser = "is_advertiser"
        case type
        case membersCount = "members_count"
        case isMember = "is_member"
        case isAdmin = "is_admin"
        case photo100 = "photo_100"
        case status, name
        case adminLevel = "admin_level"
    }
}

//enum TypeEnum: String, Codable {
//    case group = "group"
//    case page = "page"
//}


