//
//  ViewController.swift
//  EnumPractice
//
//  Created by Bohdan Tkachenko on 5/10/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let api = API()
        api.registerUser(username: "Bohdan", password: "123") { result in
            
            switch result {
            case .fail(let error):
                print("Error: \(error)")
                
            case .success(let userDictionary):
                print("User: \(userDictionary)")
            }
            
            
        }
        // Getting all events
    }


}

