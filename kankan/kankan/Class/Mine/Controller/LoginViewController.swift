//
//  LoginViewController.swift
//  kankan
//
//  Created by Xin on 16/11/9.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit


class PassViewController: UIViewController, WXNavigationProtocol {
    var faceView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
       
    }
    func configUI() {
        self.view.backgroundColor = UIColor.whiteColor()
        faceView = NSBundle.mainBundle().loadNibNamed("LoginView", owner: nil, options: nil).last as! LoginView
        faceView.frame = CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64)
        faceView.closure = { [unowned self] (name, password) in
            if name == "" || password == "" {
                let alert = UIAlertController(title: "温馨提醒", message: "用户名或密码不能为空", preferredStyle: .Alert)
                let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                
                
            }

            
        }
        
        self.view.addSubview(faceView)
        addBottomImage()
        addTitle("登录")
        addBarButton("注册", postion: .right, select: #selector(registerBtn))
        addBarButton(imageName: "app_nav_back_normal", bgImageName: "app_nav_back_clicked", postion: .left, select: #selector(backAction))
    }

    func registerBtn() {
        let registerVC = SigninViewController()
        navigationController?.pushViewController(registerVC, animated: true)
        
    }
    func backAction() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
