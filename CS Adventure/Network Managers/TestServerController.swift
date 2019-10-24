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
    
    var key: String? {
        didSet {
            print(key)
        }
    }
    var ourPlayer: Player?
    var rooms: [MappedRoom]?
    let testServerURL = URL(string: "https://lambda-mud-test.herokuapp.com/")!

    // MARK: - Enum
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    init() {
        parseRooms(fileName: "GeneratedRooms")
    }

    // MARK: - Registration
    
    func registerUser(username: String, password1: String, password2: String, completion: @escaping (Error?) -> Void) {
        
        let requestURL = testServerURL.appendingPathComponent("api")
            .appendingPathComponent("registration/")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let newUser = User(username: username, password1: password1, password2: password2)
        
        do {
            request.httpBody = try JSONEncoder().encode(newUser)
        } catch {
            NSLog("Error encoding user: \(error)")
            return completion(error)
        }
        
        //Clearing cookies, otherwise will recieve CSRF error
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error registering user: \(error)")
                return completion(error)
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return completion(nil)
            }
            
            do {
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.key = bearer.key
                completion(nil)
            } catch {
                NSLog("Error decoding key: \(error)")
                return completion(error)
            }
        }.resume()
    }
    
    func loginUser(username: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let requestURL = testServerURL.appendingPathComponent("api")
            .appendingPathComponent("login")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let user = User(username: username, password1: password)
        
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            NSLog("Error encoding user: \(error)")
            return completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error logging in: \(error)")
                return completion(error)
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return completion(nil)
            }
            
            do {
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.key = bearer.key
                completion(nil)
            } catch {
                NSLog("Error decoding key: \(error)")
                return completion(error)
            }
            
        }.resume()
    }
    
    
    // MARK:- Player / Room
    
    // We initialize the player after the token is received
    func initializePlayer(completion: @escaping (Error?, Player?) -> Void) {
        
        let requestURL = testServerURL.appendingPathComponent("api").appendingPathComponent("adv").appendingPathComponent("init")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        guard let key = key else {return NSLog("Error: Key does not exist.")}
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(key)", forHTTPHeaderField: "Authorization")
                
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
    
    // We pass the direction we are headed and receive back the next room we are going to
    func moveOneStep(direction: Direction, completion: @escaping (Error?, Room?) -> Void){
        
        guard let token = key else { return NSLog("Error retrieving token from class.")}
        let requestURL = testServerURL.appendingPathComponent("api").appendingPathComponent("adv").appendingPathComponent("move")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
                
        let passedDirectionDict = ["direction": direction]
        
        do {
            request.httpBody = try JSONEncoder().encode(passedDirectionDict)
        } catch {
            NSLog("Error encoding user: \(error)")
            return completion(error, nil)
        }
        
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
                let room = try JSONDecoder().decode(Room.self, from: data)
                print("HERE room pulled: ", room.name, room.title, room)
                completion(nil, room)
            } catch {
                NSLog("Error decoding key: \(error)")
                return completion(error, nil)
            }
        }.resume()
    }
    
    
    func parseRooms(fileName: String) {
    
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
            
        
        do {
            let data = try Data(contentsOf: url)
            let rooms = try JSONDecoder().decode([MappedRoom].self, from: data)
            self.rooms = rooms
        } catch {
            NSLog("Error decoding rooms: \(error)")
            return
        }

    }
    
    
    
}
