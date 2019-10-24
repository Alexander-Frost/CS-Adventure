//
//  LandingViewController.swift
//  CS Adventure
//
//  Created by Kobe McKee on 10/23/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    
    let controller = TestServerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "testSegue" {
            guard let destinationVC = segue.destination as? MapViewController else { return }
            destinationVC.controller = controller
        }
    }
    

}
