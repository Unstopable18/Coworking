//
//  Slot.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

struct GetSlotsModel: Codable {
    let slots: [Slot]?
}

struct Slot: Codable {
    let slotName: String?
    let slotID: Int?
    let slotActive: Bool?

    enum CodingKeys: String, CodingKey {
        case slotName = "slot_name"
        case slotID = "slot_id"
        case slotActive = "slot_active"
    }
}

struct AvailableTimeModel: Codable {
    let availability: [Availability]?
}

struct Availability: Codable {
    let workspaceName: String?
    let workspaceID: Int?
    let workspaceActive: Bool?

    enum CodingKeys: String, CodingKey {
        case workspaceName = "workspace_name"
        case workspaceID = "workspace_id"
        case workspaceActive = "workspace_active"
    }
}

struct ConfirmBookingModel:Codable{
       let message: String?
}
