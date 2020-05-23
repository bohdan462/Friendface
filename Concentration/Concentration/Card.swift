//
//  Card.swift
//  Concentration
//
//  Created by Bohdan Tkachenko on 5/3/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation

struct Card { // model
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0 //static available only for type. Example Card.dentifierFactory
    
    static func getUniqueIdentifier() -> Int { 
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}


