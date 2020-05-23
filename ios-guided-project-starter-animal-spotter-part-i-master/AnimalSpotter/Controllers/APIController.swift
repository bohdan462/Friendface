//
//  APIController.swift
//  AnimalSpotter
//
//  Created by Ben Gohlke on 4/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

final class APIController { //final cannot be subclassed prevent to use api controller and adding functionality to it
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkError: Error {
        case noData
        case failedSignUp
        case failedSignIn
        case noToken
    }
    
    private let baseURL = URL(string: "https://lambdaanimalspotter.herokuapp.com/api")!
    private lazy var signUpURL = baseURL.appendingPathComponent("/users/signup")
    private lazy var signInURL = baseURL.appendingPathComponent("/users/login")
    var bearer: Bearer?
    
    // create function for sign up
    
    func signUp(with user: User, completion: @escaping (Result<Bool, NetworkError>) -> Void) { //Result has .failer and .success
        print("signUpURL = \(signUpURL.absoluteString)")
        
        var request = postRequest(for: signUpURL)
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(user)
            print(String(data: jsonData, encoding: .utf8)!)
            request.httpBody = jsonData
            //header is mettadata and body is actual data ie jsone
            
            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                //Check for error first
                if let error = error {
                    print("SignUp is failed with error: \(error)")
                    completion(.failure(.failedSignUp))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else { print("SignUp was unsuccessful")
                        completion(.failure(.failedSignUp))
                        return
                        
                }
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error with \(error)")
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
                //handle error
                if let error = error {
                    print("Sign in failed with error: \(error)")
                    completion(.failure(.failedSignIn))
                }
                //handle response
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("SignIn was unsuccessful")
                        completion(.failure(.failedSignIn))
                        return
                }
                //handle data we should recive TOKEN
                guard let data = data else {
                    print("data was not recieved")
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    self.bearer = try decoder.decode(Bearer.self, from: data)
                    completion(.success(true))
                } catch {
                    print("Error decoding with \(error)")
                    completion(.failure(.noToken))
                }
            }.resume()
        } catch {
            print("Etrror encoding user: \(error)")
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
    
    // create function for fetching animal details
    
    // create function to fetch image
}
