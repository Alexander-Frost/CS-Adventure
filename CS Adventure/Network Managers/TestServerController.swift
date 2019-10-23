//
//  TestServerController.swift
//  CS Adventure
//
//  Created by Alex on 10/22/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class TestServerController {
    
    // MARK: - Properties
    
    var key: String?
    var ourPlayer: Player?
    let testServerURL = URL(string: "https://lambda-mud-test.herokuapp.com/")!

    // MARK: - Enum
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

    // MARK: - Public
    
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
    
    // We initialize the player after the token is received
    func initializePlayer(token: String, completion: @escaping (Error?, Player?) -> Void) {
        
        let requestURL = testServerURL.appendingPathComponent("api").appendingPathComponent("adv").appendingPathComponent("init")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
                
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error logging in: \(error)")
                return completion(error, nil)
            }
            guard let data = data else {
                NSLog("No data returned")
                return completion(nil, nil)
            }
            
            do {
                let player = try JSONDecoder().decode(Player.self, from: data)
                self.ourPlayer = player
                print("HERE player pulled: ", player, player.name, player.title, player.uuid)
                completion(nil, player)
            } catch {
                NSLog("Error decoding key: \(error)")
                return completion(error, nil)
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
