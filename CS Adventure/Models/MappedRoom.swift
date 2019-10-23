//
//  MappedRoom.swift
//  CS Adventure
//
//  Created by Kobe McKee on 10/23/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

struct MappedRoom: Codable {
    
    let id: Int
    let name: String
    let description: String
    
    var nTo: Int?
    var sTo: Int?
    var eTo: Int?
    var wTo: Int?
    
    let x: Int
    let y: Int
    

}
