//
//  TestServerController.swift
//  CS Adventure
//
//  Created by Kobe McKee on 10/22/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class TestServerController {
    
    var key: String?
    let testServerURL = URL(string: "https://lambda-mud-test.herokuapp.com/")!

    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

    func registerUser(username: String, password1: String, password2: String, completion: @escaping (Error?) -> Void) {
        
        let requestURL = testServerURL
            .appendingPathComponent("api")
            .appendingPathComponent("registration/")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let newUser = User(username: username, password1: password1, password2: password2)
        
        do {
            request.httpBody = try JSONEncoder().encode(newUser)
        } catch {
            NSLog("Error encoding user: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error registering user: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(nil)
                return
            }
            
            do {
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.key = bearer.key
                completion(nil)
            } catch {
                NSLog("Error decoding key: \(error)")
                completion(error)
                return
            }

            
        }.resume()
    }
    
    
    
    func loginUser(username: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let requestURL = testServerURL
            .appendingPathComponent("api")
            .appendingPathComponent("login")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let user = User(username: username, password1: password)
        
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            NSLog("Error encoding user: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error logging in: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(nil)
                return
            }
            
            do {
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.key = bearer.key
                completion(nil)
            } catch {
                NSLog("Error decoding key: \(error)")
                completion(error)
                return
            }
            
        }.resume()
        
        
    }
    
    
    
    
}
