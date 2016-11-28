//
//  LoginView.swift
//  kankan
//
//  Created by Xin on 16/11/9.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    
    @IBAction func loginAction(sender: UIButton) {
        if sender.tag == 100 {
            print("登录成功")
        } else if sender.tag == 101 {
            print("密码找回")
        }
        
    }
   
    
    
}
