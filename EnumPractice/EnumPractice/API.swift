//
//  API.swift
//  EnumPractice
//
//  Created by Bohdan Tkachenko on 5/10/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation


class API {
    
    
    enum RegisterUserResult {
        case fail(Error)
        case success([String: Any])
    }
    
    
    func registerUser(username: String, password: String, completion: @escaping (RegisterUserResult) -> () ) {
        
        let url = URL(string: "https://demo0638130.mockable.io/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let requestDataDictionary = [
            "username": username,
            "password": password
        ]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: requestDataDictionary)
        
        let task = URLSession.shared.dataTask(with: request) { (possibleData, possibleResponse, possibleError) in
           
            
            guard possibleError == nil else {
                completion(.fail(possibleError!))
                return
                
            }
            guard let existindData = possibleData else {
                
                completion(.fail(NSError(domain: "Invalid state", code: 1, userInfo: nil)))
                return
            }
            guard let parsedJSON = try! JSONSerialization.jsonObject(with: existindData) as? [String: Any] else {
                completion(.fail(NSError(domain: "Invalis Data", code: 2, userInfo: nil)))
                return
            }
            
            completion(.success(parsedJSON))
        }
        task.resume()
    }
}
