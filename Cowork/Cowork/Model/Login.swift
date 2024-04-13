//
//  Login.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

struct Login: Codable {
    let userID: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case message = "message"
    }
}
