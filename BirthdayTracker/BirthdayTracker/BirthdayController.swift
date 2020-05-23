//
//  BirthdayController.swift
//  BirthdayTracker
//
//  Created by Bohdan Tkachenko on 4/30/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation

class BirthdayController {
    var birthdays: [Birthday] = []
    
    
    //CRUD
    func createBirthday(name: String, date: Date) {
        let birthday = Birthday(name: name, date: date)
        birthdays.append(birthday)
    }
    
    
    
    //Save and Load
    
    var persistentFileURL: URL? {
        let fm = FileManager.default
        let documents = fm.urls(for: .documentDirectory, in: .userDomainMask).first
        return documents?.appendingPathComponent("birthdays.plist")
    }
    
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.birthdays)
            try data.write(to: url)
        } catch {
            print("Error")
        }
    }
    
    func loadFromPersistetStore() {
        let fm = FileManager.default
        guard let url = self.persistentFileURL,
            fm.fileExists(atPath: url.path) else {return}
        
        do {
            let data = try Data 
        }
    }
}
