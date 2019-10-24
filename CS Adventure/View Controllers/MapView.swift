//
//  MapView.swift
//  CS Adventure
//
//  Created by Kobe McKee on 10/23/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit


class MapView: UIView {
    
    var controller: TestServerController? {
        didSet {
            self.rooms = controller?.rooms
        }
    }
    var rooms: [MappedRoom]?
    
    

    
    
    override func draw(_ rect: CGRect) {
        
        guard let rooms = rooms else { return }
        let context = UIGraphicsGetCurrentContext()!
        
        let xfactor = frame.maxX / 16
        let yfactor = frame.maxY / 17
        
        let seperator = frame.maxX / 20
        
        for room in rooms {
            
            let rect = CGRect(x: CGFloat(room.x)*xfactor, y: CGFloat(room.y)*yfactor, width: seperator, height: seperator)
            
            let idLabel = UILabel(frame: rect)
            idLabel.text = String(room.id)
            idLabel.textAlignment = .center
            idLabel.adjustsFontSizeToFitWidth = true
            idLabel.backgroundColor = .white
            self.addSubview(idLabel)
            
            context.stroke(rect)
            
        }
        
        
        for room1 in rooms {
            
            for room2 in rooms {
                
                if abs(room1.x - room2.x) == 1 && abs(room1.y - room2.y) == 1 {
                    continue
                }
                
                if abs(room1.x - room2.x) == 1 && abs(room1.y - room2.y) == 0 ||
                    abs(room1.y - room2.y) == 1 && abs(room1.x - room2.x) == 0 {
                    tunnel(room1: room1, room2: room2)
                }
            }
        }
    }
    
    
    
    func tunnel(room1: MappedRoom, room2: MappedRoom) {
        let context = UIGraphicsGetCurrentContext()!
        let xfactor = frame.maxX / 16
        let yfactor = frame.maxY / 17
        let seperator = frame.maxX / 20
        
        print("Tunnelling: \(room1.id) -> \(room2.id)")
        
        let room1Rect = CGRect(x: CGFloat(room1.x)*xfactor, y: CGFloat(room1.y)*yfactor, width: seperator, height: seperator)
        
        let room2Rect = CGRect(x: CGFloat(room2.x)*xfactor, y: CGFloat(room2.y)*yfactor, width: seperator, height: seperator)
        
        let room1Point = CGPoint(x: room1Rect.midX, y: room1Rect.midY)
        let room2Point = CGPoint(x: room2Rect.midX, y: room2Rect.midY)
        
        context.move(to: room1Point)
        context.addLine(to: room2Point)
        context.strokePath()

    }
    
    
    
    
}
