//
//  Friend.swift
//  FriendFace
//
//  Created by Bohdan Tkachenko on 5/10/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation


struct Friend: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Connection]
}
