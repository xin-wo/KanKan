//
//  MineViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/19.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class MineViewController: UIViewController, WXNavigationProtocol {

    var tableView: UITableView!
    //所有cell的名称
    var cellNames = ["开通看看会员", "播放记录", "追剧", "收藏", "购买记录", "扫一扫", "远程设备管理", "设置", "反馈"]
    
    
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
            cell.descLabel.text = "登入后支持云同步及访问更多特权"
            cell.titleLabel.text = "点击登录"
            cell.userImage.image = UIImage(named: "zxc")
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
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0 {
           
            let LVC = PassViewController()
            
            LVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(LVC, animated: true)
            
            
        }
    }
    
    
}








