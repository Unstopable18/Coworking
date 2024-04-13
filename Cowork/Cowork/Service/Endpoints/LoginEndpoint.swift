//
//  LoginEndpoint.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

class LoginEndpoint{
    
    enum Endpoint {
        case login
        case getSlots(date: String)
        case createAccount
        var urlString: String {
            switch self {
            case .login:
                return "https://demo0413095.mockable.io/digitalflake/api/login"
            case .getSlots(let date):
                return "https://demo0413095.mockable.io/digitalflake/api/get_slots?date=\(date)"
            case .createAccount:
                return "https://demo0413095.mockable.io/digitalflake/api/create_account"
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Login, APIError>) -> Void) {
        let url = URL(string: Endpoint.login.urlString)!
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters = ["email": email, "password": password]
        
        APIManager.shared.makeAPIRequest(url: url, method: "POST", headers: headers, parameters: parameters, completion: completion)
    }
    
    func register(email: String, name: String, completion: @escaping (Result<Login, APIError>) -> Void) {
        let url = URL(string: Endpoint.login.urlString)!
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters = ["email": email, "name": name]
        
        APIManager.shared.makeAPIRequest(url: url, method: "POST", headers: headers, parameters: parameters, completion: completion)
    }
    func getSlots(date: String, completion: @escaping (Result<Data, APIError>) -> Void) {
        let url = URL(string: Endpoint.getSlots(date: date).urlString)!
        
        APIManager.shared.makeAPIRequest(url: url, method: "GET", headers: nil, parameters: nil, completion: completion)
    }
    
    
}
