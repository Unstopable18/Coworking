//
//  DashboardInteractor.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

enum isFromRoomOrDesk:Int{
    
    case Room = 2
    case Desk = 1
    var title:String{
        switch self{
        case .Desk:
            return "Desk"
        case .Room:
            return "Room"
        }
    }
}

class DashboardInteractor{
    
    var bookingModel:BookingHistoryModel?
    var dashBoardOption:isFromRoomOrDesk = .Desk
    var dateSelected:String?
    var selectedDate = ""{
        didSet{
           dateSelected = dateStringToCustomFormat(selectedDate)
            
        }
    }
    var selectedSeat:Availability?
    var selectedSlot:Slot?
    var slotModel:GetSlotsModel?
    var serviceLayer = DashboardEndpoint()
    var availableSlotModel:AvailableTimeModel?
    func dateStringToCustomFormat(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "E dd MMM"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }

    func getSlots(date:String,completion:@escaping(Bool)->()){
        serviceLayer.getSlots(date: date) { result in
            switch result{
                
            case .success(let model):
                self.slotModel = model
                completion(true)
            case .failure(let err):
                debugPrint(err)
                completion(false)
            }
        }
        
    }
    func getAvailibilty(completion:@escaping(Bool)->()){
        serviceLayer.getAvailability(date: selectedDate, slotID: selectedSlot?.slotID ?? 0, type: dashBoardOption.rawValue){ result in
            switch result{
                
            case .success(let model):
                self.availableSlotModel = model
                completion(true)
            case .failure(let err):
                debugPrint(err)
                completion(false)
            }
        }
        
    }
    func confirmBooking(completion:@escaping(Bool)->()){
        serviceLayer.confirmBooking(date: selectedDate, slotID: self.selectedSlot?.slotID ?? 0, workspaceID: self.selectedSeat?.workspaceID ?? 0, type: dashBoardOption.rawValue) { result in
            switch result {
            case .success(let data):
                print(data)
                completion(true)
               
            case .failure(let error):
                
                completion(false)
                debugPrint("Error confirming booking: \(error)")
            }
        }
    }
    
    func getBookingHistory(completion:@escaping(Bool)->()){
        let userId = UserDefaults.standard.value(forKey: "userId")
        serviceLayer.getBookings(userID:userId as! String) { result in
            switch result {
            case .success(let data):
                self.bookingModel = data
                completion(true)
            case .failure(let error):
                print("Error fetching bookings: \(error)")
                completion(false)
               
            }
        }
    }
    
    
    
    
}
