//
//  Popup.swift
//  CS Adventure
//
//  Created by Alex on 10/24/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class Popup {
    
    static func showAlert(on: UIViewController, style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [ UIAlertAction(title: "OK", style: .default, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        on.present(alert, animated: true, completion: completion)
    }
}
