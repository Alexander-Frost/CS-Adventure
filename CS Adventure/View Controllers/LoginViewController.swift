//
//  LoginViewController.swift
//  CS Adventure
//
//  Created by Alex on 10/22/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Instances
    
    private let registrationController = TestServerController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK: - Actions
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        guard let userName = userNameTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        
        registrationController.loginUser(username: userName, password: pass) { (err) in
            if let err = err {return NSLog("Error logging in: ", err.localizedDescription)}
        }
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
