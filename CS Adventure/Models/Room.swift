//
//  Room.swift
//  CS Adventure
//
//  Created by Alex on 10/23/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

struct Room: Codable {
    let title: String
    let name: String
    let description: String
    var errorMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case name
        case description
        
        case errorMsg = "error_msg"
    }
}
