//
//  CommentViewController.swift
//  kankan
//
//  Created by Xin on 16/11/7.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, WXNavigationProtocol {
    var titleString: String = ""
    var textFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        
    }
    func configUI() {
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = titleString
        addBottomImage()
        addBarButton(imageName: "app_nav_back_normal", bgImageName: "app_nav_back_clicked", postion: .left, select: #selector(backAction))
        textFiled = UITextField(frame: CGRect(x: 70, y: 100, width: screenWidth-100, height: 30))
        textFiled.backgroundColor = UIColor.lightGrayColor()
        textFiled.placeholder = "人人都是段子手，来一段呗！"
        textFiled.clearsOnBeginEditing = true
        textFiled.font = UIFont.systemFontOfSize(15)
        view.addSubview(textFiled)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 90, width: 50, height: 50))
        imageView.image = UIImage(named: "zxc")
        view.addSubview(imageView)
    }
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
