//
//  Booking.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

struct BookingHistoryModel: Codable {
    let bookings: [Booking]?
}

struct Booking: Codable {
    let workspaceName: String?
    let workspaceID: Int?
    let bookingDate: String?

    enum CodingKeys: String, CodingKey {
        case workspaceName = "workspace_name"
        case workspaceID = "workspace_id"
        case bookingDate = "booking_date"
    }
}

