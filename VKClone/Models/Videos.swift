//
//  Videos.swift
//  vk-tanya
//
//  Created by Tanya on 22.08.2022.
//

import Foundation

// MARK: - VideoResponse
struct VideoResponse: Codable {
    let response: VideoItems
}

// MARK: - Response
struct VideoItems: Codable {
    let count: Int
    let items: [Video]
}

// MARK: - Item
struct Video: Codable {
    let ownerID: Int?
    let title: String
    let player: String

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case title
        case player
    }
}

