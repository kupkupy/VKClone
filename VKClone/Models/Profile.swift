//
//  Info.swift
//  RealProject
//
//  Created by Tanya on 27.05.2022.
//

import Foundation

// MARK: - InfoResponse
struct ProfileResponse: Codable {
    let response: [Profile]
}

// MARK: - Response
struct Profile: Codable {
    let id: Int //faculty
    let isClosed: Bool?
    //let facultyName: String
    //let cropPhoto: CropPhoto
    let canAccessClosed: Bool?
    //let graduation: Int
    let bdate: String
    let city: City
    //let university: Int
    let universityName: String
    let photo100: String
    let firstName: String
    let country: City
    let counters: [String: Int]
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case id//, faculty
        case isClosed = "is_closed"
        //case facultyName = "faculty_name"
        //case cropPhoto = "crop_photo"
        case canAccessClosed = "can_access_closed"
        case bdate, city, counters
        case universityName = "university_name"
        case photo100 = "photo_100"
        case firstName = "first_name"
        case country
        case lastName = "last_name"
    }
}

// MARK: - City
struct UserCity: Codable {
    let id: Int
    let title: String
}
