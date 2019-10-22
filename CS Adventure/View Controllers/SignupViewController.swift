//
//  SignupViewController.swift
//  CS Adventure
//
//  Created by Alex on 10/22/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    // MARK: - Actions
    
    @IBAction func signupBtnPressed(_ sender: UIButton) {
    
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
