//
//  Animal.swift
//  AnimalSpotter
//
//  Created by Bohdan Tkachenko on 5/11/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Animal: Codable {
    
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var timeSeen: Date
    var description: String
    var imageURL: String
    
}
