//
//  DashboardEndpoint.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

class DashboardEndpoint{
    
    enum Endpoint {
       
        case getSlots(date: String)
        case getAvailability(date: String, slotID: Int, type: Int)
        case confirmBooking(date: String, slotID: Int, workspaceID: Int, type: Int)
         case getBookings(userID: String)
        var urlString: String {
            switch self {
           
            case .getSlots(let date):
                return "https://demo0413095.mockable.io/digitalflake/api/get_slots?date=\(date)"
            case .getAvailability(let date, let slotID, let type):
                return "https://demo0413095.mockable.io/digitalflake/api/get_availability?date=\(date)&slot_id=\(slotID)&type=\(type)"
            case .confirmBooking:
                return "https://demo0413095.mockable.io/digitalflake/api/confirm_booking"
                
            case .getBookings(let userID):
                            return "https://demo0413095.mockable.io/digitalflake/api/get_bookings?user_id=\(userID)"
                
            }
        }
        
        
    }
    
    func getSlots(date: String, completion: @escaping (Result<GetSlotsModel, APIError>) -> Void) {
        let url = URL(string: Endpoint.getSlots(date: date).urlString)!
        
        APIManager.shared.makeAPIRequest(url: url, method: "GET", headers: nil, parameters: nil, completion: completion)
    }
    func getAvailability(date: String, slotID: Int, type: Int, completion: @escaping (Result<AvailableTimeModel, APIError>) -> Void) {
            let url = URL(string: Endpoint.getAvailability(date: date, slotID: slotID, type: type).urlString)!
            
        APIManager.shared.makeAPIRequest(url: url, method: "GET", headers: nil, parameters: nil, completion: completion)
        }
    
    func confirmBooking(date: String, slotID: Int, workspaceID: Int, type: Int, completion: @escaping (Result<ConfirmBookingModel, APIError>) -> Void) {
           let url = URL(string: Endpoint.confirmBooking(date: date, slotID: slotID, workspaceID: workspaceID, type: type).urlString)!
           let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters = ["date": date, "slot_id": slotID, "workspace_id": workspaceID, "type": type] as [String : Any]
           
        APIManager.shared.makeAPIRequest(url: url, method: "POST", headers: headers, parameters: parameters, completion: completion)
       }
    func getBookings(userID: String, completion: @escaping (Result<BookingHistoryModel, APIError>) -> Void) {
            let url = URL(string: Endpoint.getBookings(userID: userID).urlString)!
            
        APIManager.shared.makeAPIRequest(url: url, method: "GET", headers: nil, parameters: nil, completion: completion)
        }
}
