//
//  MapViewController.swift
//  CS Adventure
//
//  Created by Kobe McKee on 10/23/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    var rooms: [MappedRoom]? {
        didSet {
            mapRooms()
        }
    }
    var prevRoom: MappedRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testRoom()
        //loadRooms()
    }
    
    func testRoom() {
        
    }
    
    
    func loadRooms() {
        guard let path = Bundle.main.path(forResource: "39RoomTest", ofType: "json"),
            let url = URL(string: path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let rooms = try JSONDecoder().decode([MappedRoom].self, from: data)
            self.rooms = rooms
            
        } catch {
            NSLog("Error decoding rooms: \(error)")
            return
        }
    }
    
    
    
    func mapRooms() {
        
        guard let rooms = self.rooms else { return }
        
        
        
        
    }

    
    
    func drawRoom() {
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
