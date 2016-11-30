//
//  RegisterView.swift
//  kankan
//
//  Created by qianfeng on 16/11/30.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    var closure: ((String, String) -> (Void))!
   
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    
    @IBAction func registerAction(sender: AnyObject) {
        if userNameField.text == "" || passwordField.text == "" {
            closure("","")
            
        } else {
            
            closure(userNameField.text!,passwordField.text!)
        }

        
    }
    
    
}
