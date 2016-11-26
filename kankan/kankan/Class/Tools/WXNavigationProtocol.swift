//
//  WXNavigationProtocol.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import Foundation
import UIKit

enum Position {
    case left
    case right
}


protocol WXNavigationProtocol: NSObjectProtocol {
    //添加navigationBar的标题
    func addTitle(title: String)
    //添加navigationBar的左右按钮
    func addBarButton(title: String?, imageName: String?, bgImageName: String?, postion: Position, select: Selector)
    //添加navigationBar的底部图片
    func addBottomImage()
}

extension WXNavigationProtocol where Self: UIViewController {
    func addTitle(title: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        label.text = title
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(20)
        label.textAlignment = .Center
        navigationItem.titleView = label
        
    }
    func addBarButton(title: String? = nil, imageName: String? = nil, bgImageName: String? = nil, postion position: Position, select: Selector) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        if title != nil{
            button.setTitle(title, forState: .Normal)
        }
        if imageName != nil {
            button.setImage(UIImage(named: imageName!), forState: .Normal)
        }
        if bgImageName != nil{
            button.setImage(UIImage(named:bgImageName!), forState: .Highlighted)
        }
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        button.addTarget(self, action: select, forControlEvents: .TouchUpInside)
        let barButtonItem=UIBarButtonItem(customView: button)
        
        if position == .left {
            if navigationItem.leftBarButtonItems != nil{
                navigationItem.leftBarButtonItems = navigationItem.leftBarButtonItems! + [barButtonItem]
            }else{
                navigationItem.leftBarButtonItems = [barButtonItem]
            }
        }else{
            if navigationItem.rightBarButtonItems != nil{
                navigationItem.rightBarButtonItems = navigationItem.rightBarButtonItems! + [barButtonItem]
            }else{
                navigationItem.rightBarButtonItems = [barButtonItem]
            }
        }
        
    }
    
    func addBottomImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 43, width: screenWidth, height: 1))
        imageView.image = UIImage(named: "app_nav_separater")
        navigationController?.navigationBar.addSubview(imageView)
    }
    
}
