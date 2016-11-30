//
//  LoginView.swift
//  kankan
//
//  Created by Xin on 16/11/9.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class LoginView: UIView {
    var closure: ((String, String) -> (Void))!
    
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func loginAction(sender: UIButton) {
        
        if userNameField.text == "" || passwordField.text == "" {
            closure("","")
            
            
            
        } else {
            closure(userNameField.text!,passwordField.text!)
        }
        
    
    }
   
    
    
}
