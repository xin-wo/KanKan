//
//  AccountViewController.swift
//  kankan
//
//  Created by Xin on 16/12/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import MobileCoreServices

class AccountViewController: UIViewController,WXNavigationProtocol {
    
    var tableView: UITableView!
    var desText = ""
    var titleText = ""
    var userImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "账号信息"
        addBottomImage()
         addBarButton(imageName: "app_nav_back_normal", bgImageName: "app_nav_back_clicked", postion: .left, select: #selector(backAction))
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "firstMine")
        tableView.registerNib(UINib(nibName: "OtherTableViewCell", bundle: nil), forCellReuseIdentifier: "otherMine")
        self.view.addSubview(tableView)
    }
    
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        }
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("firstMine", forIndexPath: indexPath) as! MineTableViewCell
            cell.descLabel.text = desText
            cell.titleLabel.text = titleText
            cell.userImage.image = userImage
            cell.modifyLabel.text = "修改头像"
            cell.accessoryType = .DisclosureIndicator
            
            return cell

        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("otherMine", forIndexPath: indexPath) as! OtherTableViewCell
            cell.itemLabel.text = "退出登录"
            cell.accessoryType = .DisclosureIndicator
            return cell


            
        }
        
        
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let actionSheet=UIAlertController(title:nil, message: "选择图片来源", preferredStyle: .ActionSheet)
            actionSheet.addAction(UIAlertAction(title: "相机", style: .Default, handler: {[unowned self] (a) in
                self.imagePicker(.Camera)
                }))
            actionSheet.addAction(UIAlertAction(title: "相册", style: .Default, handler: {[unowned self] (a) in
                self.imagePicker(.PhotoLibrary)
                }))
            self.presentViewController(actionSheet, animated: true, completion: nil)

            
            
            
        } else if (indexPath.row == 1) {
            //退出
            let error = EMClient.sharedClient().logout(true)
            if (error == nil) {
                print("退出成功")
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
    }
    
}

extension AccountViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePicker(sourceType:UIImagePickerControllerSourceType){
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            print("不能打开\(sourceType.rawValue)")
            return
        }
        let picker=UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate=self
//        picker.allowsEditing=true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if info[UIImagePickerControllerMediaType] as? String ==  kUTTypeImage as String {
            userImage=info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        self.tableView.reloadData()
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
       
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}


