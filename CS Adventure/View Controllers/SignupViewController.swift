//
//  SignupViewController.swift
//  CS Adventure
//
//  Created by Alex on 10/22/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: - Instances
    
    private let registrationController = TestServerController()

    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    // MARK: - Actions
    
    @IBAction func signupBtnPressed(_ sender: UIButton) {
        guard let userName = usernameTextField.text, !userName.isEmpty else {return Popup.showAlert(on: self, style: .alert, title: "Signup Error", message: "Please make sure all fields are completed.")}
        guard let pass1 = passwordTextField.text, !pass1.isEmpty else {return Popup.showAlert(on: self, style: .alert, title: "Signup Error", message: "Please make sure all fields are completed.")}
        guard let pass2 = confirmPasswordTextField.text, !pass2.isEmpty else {return Popup.showAlert(on: self, style: .alert, title: "Signup Error", message: "Please make sure all fields are completed.")}
        
        
        registrationController.registerUser(username: userName, password1: pass1, password2: pass2) { (err) in
            if let err = err {return NSLog("Error registering user: ", err.localizedDescription)}
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
        signupBtn.shadowButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let destVC = segue.destination as! MapViewController
            destVC.controller = registrationController
        }
    }

}
