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
    
    // MARK: - VC Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.controller = controller
        
    }
    
    private func updateViews(){
        controller?.initializePlayer(completion: { (error, player) in
            if let error = error {return NSLog("Error initializing Player: ", error.localizedDescription)}
            
            guard let player = player else {return NSLog("Error Player does not exist")}
            
            
        })
    }
    

    
    

    
    


}
