//
//  LoginViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/11/9.
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
        self.view.addSubview(faceView)
        addBottomImage()
        addTitle("登录")
        addBarButton("注册", postion: .right, select: #selector(registerBtn))
        addBarButton(imageName: "app_nav_back_normal", bgImageName: "app_nav_back_clicked", postion: .left, select: #selector(backAction))
    }

    func registerBtn() {
      
        
    }
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
