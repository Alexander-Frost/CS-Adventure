//
//  Extensions.swift
//  CS Adventure
//
//  Created by Alex on 10/24/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

extension UIView {
    
    func shadowButton(){
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:1).cgColor
        self.layer.shadowOpacity = 0.34
        self.layer.shadowOffset = CGSize(width: 2, height: 5)
        self.layer.masksToBounds = false
    }
    
    // used to round view controller view
    func makeCorner(withRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.isOpaque = false
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.masksToBounds = true;
    }
    
    func makeDot() {
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.masksToBounds = true;
        self.backgroundColor = .blue
        self.tintColor = .blue
    }
}

