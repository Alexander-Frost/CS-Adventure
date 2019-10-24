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
    
    
    let upBtn = UIButton(type: .custom)
    let downBtn = UIButton(type: .custom)
    let leftBtn = UIButton(type: .custom)
    let rightBtn = UIButton(type: .custom)

    // MARK: - Actions
    
    @objc func upBtnPressed(sender: UIButton){
        
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
        
        var playerDot = UIView(frame: CGRect(x: 8*(xfactor), y: 0*(yfactor), width: seperator, height: seperator)) {
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
        upBtn.frame = CGRect(x: 100, y: 12, width: 29, height: 29)
        upBtn.backgroundColor = .gray
        upBtn.setImage(UIImage(named:"upArrow"), for: .normal)
        upBtn.imageView?.contentMode = .scaleAspectFit
        upBtn.makeCircle()
        upBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        upBtn.addTarget(self, action: #selector(upBtnPressed(sender:)), for: .touchUpInside)
    }
    
    

    
    


}
