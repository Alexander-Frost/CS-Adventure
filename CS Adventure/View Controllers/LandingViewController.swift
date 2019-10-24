//
//  LandingViewController.swift
//  CS Adventure
//
//  Created by Kobe McKee on 10/23/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    // MARK: - Instances
    
    let controller = TestServerController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "testSegue" {
            guard let destinationVC = segue.destination as? MapViewController else { return }
            destinationVC.controller = controller
        }
    }
    
    // MARK: - UI
    
    private func updateViews(){
        loginBtn.makeCorner(withRadius: 12.0)
        signupBtn.makeCorner(withRadius: 12.0)
    }
    

}
