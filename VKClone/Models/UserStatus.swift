//
//  UserStatus.swift
//  RealProject
//
//  Created by Tanya on 16.06.2022.
//

import Foundation

// MARK: - StatusResponse
struct StatusResponse: Codable {
    let response: Status
}

// MARK: - Response
struct Status: Codable {
    let text: String
}
