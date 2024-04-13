//
//  LoginInteractor.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

class LoginInteractor{
    let serviceLayer = LoginEndpoint()
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        serviceLayer.login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                print(data)
                UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
                completion(true)
                UserDefaults.standard.setValue("\(data.userID ?? 0)", forKey: "userId")
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
}
