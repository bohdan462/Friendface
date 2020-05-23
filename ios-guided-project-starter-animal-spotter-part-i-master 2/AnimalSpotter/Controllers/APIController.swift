//
//  APIController.swift
//  AnimalSpotter
//
//  Created by Ben Gohlke on 4/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

final class APIController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkError: Error {
        case noData, failedSignUp, failedSignIn, noToken, tryAgain, invalidURl
    }
    
    private let baseURL = URL(string: "https://lambdaanimalspotter.herokuapp.com/api")!
    private lazy var signUpURL = baseURL.appendingPathComponent("/users/signup")
    private lazy var signInURL = baseURL.appendingPathComponent("/users/login")
    private lazy var allAnimalsURL = baseURL.appendingPathComponent("/animals/all")
    private lazy var animalDetailURL = baseURL.appendingPathComponent("/animals")
    var bearer: Bearer?
    
    
    // create function for sign up
    
    func signUp(with user: User, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        print("signUpURL = \(signUpURL.absoluteString)")
        
        var request = postRequest(for: signUpURL)
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(user)
            print(String(data: jsonData, encoding: .utf8)!)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                // Check for error first
                if let error = error {
                    print("Sign up failed with error: \(error)")
                    completion(.failure(.failedSignUp))
                    return
                }
                
                // Check for response and make sure it is a 200
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Sign up was unsuccessful")
                        completion(.failure(.failedSignUp))
                        return
                }
                
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding user: \(error)")
            completion(.failure(.failedSignUp))
        }
    }
    
    // create function for sign in
    func signIn(with user: User, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        
        var request = postRequest(for: signInURL)
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Handle Error
                if let error = error {
                    print("Sign in failed with error \(error)")
                    completion(.failure(.failedSignIn))
                    return
                }
                
                // Handle Response
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Sign in was unsuccessful")
                        completion(.failure(.failedSignIn))
                        return
                }
                
                // Handle Data
                guard let data = data else {
                    print("Data was not received")
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    self.bearer = try decoder.decode(Bearer.self, from: data)
                    completion(.success(true))
                } catch {
                    print("Error decoding bearer: \(error)")
                    completion(.failure(.noToken))
                    return
                }
            }.resume()
        } catch {
            print("Error encoding user: \(error)")
            completion(.failure(.failedSignIn))
        }
    }
    
    private func postRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // create function for fetching all animal names
    
    func fetchAllAnimalNames(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        //Make sure user is aithenticated through bearer token
        guard let bearer = self.bearer else {
            completion(.failure(.noToken))
            return
        }
        
        var request = URLRequest(url: allAnimalsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        //cerate data task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //handle error first ALWAYS
            if let error = error {
                print("Error reciving animal data wiht \(error)")
                completion(.failure(.tryAgain))
                return
            }
            //handle response
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noToken))
                return
            }
            //handle data
            guard let data = data else {
                print("No data received from getAllAnimals")
                completion(.failure(.noData))
                return
            }
            //Decode data
            do {
                let decoder = JSONDecoder()
                let animalNames = try decoder.decode([String].self, from: data)
                completion(.success(animalNames))
            } catch {
                print("Erorr decoding animaName \(error)")
                completion(.failure(.tryAgain))
                return
            }
        }
        task.resume()
    }
    
    
    
    // create function for fetching animal details
    func fetchDetail(for animalName: String, completion: @escaping (Result<Animal, NetworkError>) -> Void) {
        guard let bearer = self.bearer else {
            completion(.failure(.noToken))
            return
        }
        
        var request = URLRequest(url: animalDetailURL.appendingPathComponent(animalName))
        request.httpMethod  = HTTPMethod.get.rawValue
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching data \(error)")
                completion(.failure(.tryAgain))
                return
            }
            // Handle Response
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    print("Sign in was unsuccessful")
                    completion(.failure(.failedSignIn))
                    return
            }
            //handle data
            guard let data = data else {
                print("No data received from fetch details: \(animalName)")
                completion(.failure(.noData))
                return
                
            }
            
            //Decode this data
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let animal = try decoder.decode(Animal.self, from: data)
                completion(.success(animal))
            } catch {
                print("Error decoding animal detail data (animal name: \(animalName) : \(error)")
                completion(.failure(.noData))
                return
            }
        }
        task.resume()
        // create function to fetch image
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageURL = URL(string: urlString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving animal image with error \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }
        task.resume()
    }
}
