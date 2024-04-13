//
//  SignupInteractor.swift
//  Coworking
//
//  Created by Vaishnavi Deshmukh on 13/04/24.
//

import Foundation

class SignupInteractor {
    let serviceLayer = LoginEndpoint()
    func registerUser(email: String, name: String, completion: @escaping (Bool) -> Void) {
        serviceLayer.register(email: email, name: name) { result in
            switch result {
            case .success(let data):
                
                print(data)
                UserDefaults.standard.setValue(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.setValue("\(data.userID ?? 0)", forKey: "userId")
                completion(true)
                
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
}
