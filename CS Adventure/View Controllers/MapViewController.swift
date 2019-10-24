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

    // MARK: - Instnces
    
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
//        if let controller = controller {
//            mapView.controller = controller
//        }

    }
    

    
    

    
    


}
