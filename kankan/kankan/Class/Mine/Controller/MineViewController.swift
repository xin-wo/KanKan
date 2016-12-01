//
//  MineViewController.swift
//  kankan
//
//  Created by Xin on 16/10/19.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class MineViewController: UIViewController, WXNavigationProtocol {

    var tableView: UITableView!
    //所有cell的名称
    var cellNames = ["开通看看会员", "", "追剧", "收藏", "购买记录", "扫一扫", "远程设备管理", "设置", "反馈"]
    var desText = "登入后支持云同步及访问更多特权"
    var titleText = "点击登录"
    var userImage = UIImage(named: "default_poster_250_350")
    
    var hasLogin = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    
    }
   
    func configUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()

        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-108), style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "firstMine")
        tableView.registerNib(UINib(nibName: "OtherTableViewCell", bundle: nil), forCellReuseIdentifier: "otherMine")
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        
        addTitle("个人中心")
        addBottomImage()
        addBarButton(imageName: "app_nav_back_normal", bgImageName: "app_nav_back_clicked", postion: .left, select: #selector(backAction))
    
    }
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}

//MARK：UITableView代理
extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNames.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("firstMine", forIndexPath: indexPath) as! MineTableViewCell
            cell.descLabel.text = desText
            cell.titleLabel.text = titleText
            cell.userImage.image = userImage
            cell.accessoryType = .DisclosureIndicator
            
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("otherMine", forIndexPath: indexPath) as! OtherTableViewCell
            cell.itemLabel.text = "播放记录"
            cell.smallImage.image = UIImage(named: "app_nav_history_clicked")
            
            cell.accessoryType = .DisclosureIndicator
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("otherMine", forIndexPath: indexPath) as! OtherTableViewCell
            cell.itemLabel.text = cellNames[indexPath.row-1]
            cell.accessoryType = .DisclosureIndicator
           
            return cell

        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        }
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0 {
            if hasLogin {
                let AVC = AccountViewController()
                AVC.desText = self.desText
                AVC.titleText = self.titleText
                AVC.userImage = self.userImage
                AVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(AVC, animated: true)
                
            } else {
                let LVC = PassViewController()
                LVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(LVC, animated: true)
            }
            
        } else if indexPath.row == 2 {
            let vc = HistoryViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    
}








