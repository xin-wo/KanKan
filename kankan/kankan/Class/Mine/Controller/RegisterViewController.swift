//
//  RegisterViewController.swift
//  kankan
//
//  Created by qianfeng on 16/11/30.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import MobileCoreServices

//登录视图控制器
class SigninViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, WXNavigationProtocol {
    
    var signinView: RegisterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congfigUI()
       
    }
    func congfigUI() {
        self.view.backgroundColor = UIColor.whiteColor()
        signinView = NSBundle.mainBundle().loadNibNamed("RegisterView", owner: nil, options: nil).last as! RegisterView
        signinView.frame = CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64)
        
        signinView.closure = { [unowned self] (name, password) in
            if name == "" || password == "" {
                let alert = UIAlertController(title: "温馨提醒", message: "用户名或密码不能为空", preferredStyle: .Alert)
                let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                print("注册成功！")
                let mineVC = MineViewController()
                mineVC.desText = "您尚未开通看看会员"
                mineVC.titleText = name
                mineVC.userImage = self.signinView.userImage.image
                self.navigationController?.pushViewController(mineVC, animated: true)
                
            }
            
        }
        //添加点击手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        signinView.userImage.addGestureRecognizer(tap)
        //密文状态
        signinView.passwordField.secureTextEntry = true
        
        self.view.addSubview(signinView)
        addTitle("注册")
        addBottomImage()
        addBarButton(imageName: "app_nav_back_normal", bgImageName: "app_nav_back_clicked", postion: .left, select: #selector(backAction))
    }
    
    func changeImage() {
        
        let imageCtrl = UIImagePickerController()
        imageCtrl.sourceType = .PhotoLibrary
        imageCtrl.delegate = self
        self.presentViewController(imageCtrl, animated: true, completion: nil)
        
    }
    
    
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
//MARK: UIImagePickerController代理
extension SigninViewController {
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if info[UIImagePickerControllerMediaType] as? String ==  kUTTypeImage as String {
            
            signinView.userImage.image=info[UIImagePickerControllerOriginalImage] as? UIImage
            
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    

    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
}
