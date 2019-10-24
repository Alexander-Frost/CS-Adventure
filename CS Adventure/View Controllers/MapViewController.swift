//
//  MapViewController.swift
//  CS Adventure
//
//  Created by Kobe McKee on 10/23/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // MARK: - Received
    
    var controller: TestServerController?

    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MapView!
    
    var playerDot = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 10))
    var playerX = 8
    var playerY = 0
    
    let upBtn = UIButton(type: .custom)
    let downBtn = UIButton(type: .custom)
    let leftBtn = UIButton(type: .custom)
    let rightBtn = UIButton(type: .custom)

    // MARK: - Actions
    
    @objc func upBtnPressed(sender: UIButton){
        movePlayer(direction: "n")
        print("Up button pressed")
    }
    @objc func downBtnPressed(sender: UIButton){
        movePlayer(direction: "s")
        print("Down button pressed")
    }
    @objc func leftBtnPressed(sender: UIButton){
        movePlayer(direction: "w")
        print("Left button pressed")
    }
    @objc func rightBtnPressed(sender: UIButton){
        movePlayer(direction: "e")
        print("Right button pressed")
    }
    
    // MARK: - VC Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.controller = controller
        
        let xfactor = mapView.frame.maxX / 16
        let yfactor = mapView.frame.maxY / 17
        
        let seperator = mapView.frame.maxX / 22
        
        var playerDot = UIView(frame: CGRect(x: CGFloat(playerX)*xfactor, y: CGFloat(playerY)*yfactor, width: seperator, height: seperator)) {
            didSet {
                playerDot.makeCircle()
            }
        }
        
        playerDot.makeCircle()
        mapView.addSubview(playerDot)
    }
    
    private func updateViews(){
        setupUI()
        controller?.initializePlayer(completion: { (error, player) in
            if let error = error {return NSLog("Error initializing Player: ", error.localizedDescription)}
            
            guard let player = player else {return NSLog("Error Player does not exist")}
            
            
        })
    }


    private func setupUI(){
        // Up button
        upBtn.frame = CGRect(x: 100, y: 300, width: 60, height: 60) //UIScreen.main.bounds.maxY
        upBtn.backgroundColor = .clear
        upBtn.setImage(UIImage(named:"upArrow"), for: .normal)
        upBtn.imageView?.contentMode = .scaleAspectFit
        upBtn.makeCircle()
        upBtn.addTarget(self, action: #selector(upBtnPressed(sender:)), for: .touchUpInside)

        // Down button
        downBtn.frame = CGRect(x: 100, y: 300, width: 60, height: 60) //UIScreen.main.bounds.maxY
        downBtn.backgroundColor = .clear
        downBtn.setImage(UIImage(named:"upArrow"), for: .normal)
        downBtn.imageView?.contentMode = .scaleAspectFit
        downBtn.makeCircle()
        downBtn.addTarget(self, action: #selector(downBtnPressed(sender:)), for: .touchUpInside)
        
        // Left button
        leftBtn.frame = CGRect(x: 100, y: 300, width: 60, height: 60) //UIScreen.main.bounds.maxY
        leftBtn.backgroundColor = .clear
        leftBtn.setImage(UIImage(named:"upArrow"), for: .normal)
        leftBtn.imageView?.contentMode = .scaleAspectFit
        leftBtn.makeCircle()
        leftBtn.addTarget(self, action: #selector(leftBtnPressed(sender:)), for: .touchUpInside)
        
        // Right button
        rightBtn.frame = CGRect(x: 100, y: 300, width: 60, height: 60) //UIScreen.main.bounds.maxY
        rightBtn.backgroundColor = .clear
        rightBtn.setImage(UIImage(named:"upArrow"), for: .normal)
        rightBtn.imageView?.contentMode = .scaleAspectFit
        rightBtn.makeCircle()
        rightBtn.addTarget(self, action: #selector(rightBtnPressed(sender:)), for: .touchUpInside)
        
        // Player Dot
        
        playerDot.makeDot()
        
        // Add Subviews
        mapView.addSubview(playerDot)
        mapView.addSubview(upBtn)
    }
    
    
    
    func movePlayer(direction: String) {
        
        guard let controller = controller else { return }
        guard let rooms = controller.rooms else { return }
        let xfactor = mapView.frame.maxX / 16
        let yfactor = mapView.frame.maxY / 17
        
        let seperator = mapView.frame.maxX / 22
        
        switch direction {
        case "n":
            for room in rooms {
                if room.x == playerX && room.y == playerY+1 {
                    playerX = room.x
                    playerY = room.y
                    playerDot.frame = CGRect(x: CGFloat(playerX)*xfactor, y: CGFloat(playerY)*yfactor, width: seperator, height: seperator)
                }
            }
        case "e":
            for room in rooms {
                if room.x == playerX+1 && room.y == playerY {
                    playerX = room.x
                    playerY = room.y
                    playerDot.frame = CGRect(x: CGFloat(playerX)*xfactor, y: CGFloat(playerY)*yfactor, width: seperator, height: seperator)
                }
            }
        case "s":
            for room in rooms {
                if room.x == playerX && room.y == playerY-1 {
                    playerX = room.x
                    playerY = room.y
                    playerDot.frame = CGRect(x: CGFloat(playerX)*xfactor, y: CGFloat(playerY)*yfactor, width: seperator, height: seperator)
                }
            }
        case "w":
            for room in rooms {
                if room.x == playerX-1 && room.y == playerY {
                    playerX = room.x
                    playerY = room.y
                    playerDot.frame = CGRect(x: CGFloat(playerX)*xfactor, y: CGFloat(playerY)*yfactor, width: seperator, height: seperator)
                }
            }
        default:
            return
        }
    }
}
