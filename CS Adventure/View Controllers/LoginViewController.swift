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
        guard let userName = userNameTextField.text else {return Popup.showAlert(on: self, style: .alert, title: "Login Error", message: "Please make sure all fields are completed.")}
        guard let pass = passwordTextField.text else {return Popup.showAlert(on: self, style: .alert, title: "Login Error", message: "Please make sure all fields are completed.")}
        
        registrationController.loginUser(username: userName, password: pass) { (err) in
            if let err = err {return NSLog("Error logging in: ", err.localizedDescription)}
            self.performSegue(withIdentifier: "mapSegue", sender: self)
        }
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    // MARK: - UI
    
    private func updateViews(){
        loginBtn.shadowButton()
    }
        
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let destVC = segue.destination as! MapViewController
            destVC.controller = registrationController
        }
    }

}
