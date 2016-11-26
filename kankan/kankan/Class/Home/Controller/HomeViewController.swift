//
//  HomeViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/19.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import MJRefresh


class HomeViewController: UIViewController, WXNavigationProtocol {

    
    var childVcs = [UIViewController]()
    
    let titles:[String] = ["推荐", "电视剧", "电影", "网络电影", "综艺", "动漫", "少儿", "纪录片", "战争剧", "言情剧", "古装剧", "午夜放映"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configScrollView()
        
        self.configNavigationBar()
        
        let xScNavC = XScNavViewController(subViewControllers: childVcs)
        
        xScNavC.addParentController(self)
        

    }
    
    func configNavigationBar() {
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        
        
        addBarButton(imageName: "app_logo", postion: .left, select: #selector(rightClick))
        addBarButton(imageName: "app_nav_local_normal", bgImageName: "app_nav_local_click", postion: .right, select: #selector(localClick))
        addBarButton(imageName: "app_nav_history_normal", bgImageName: "app_nav_history_normal_click", postion: .right, select: #selector(historyClick))
        addBottomImage()
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth-210, height: 30))
        btn.backgroundColor = UIColor.init(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        btn.setImage(UIImage(named: "app_nav_search_normal"), forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(screenWidth-250), bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(searchClick), forControlEvents: .TouchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: btn)
        navigationItem.leftBarButtonItems = navigationItem.leftBarButtonItems! + [barButtonItem]
        
        
        
        
     
    }
    
  
    
    //配置scrollview
    func configScrollView()  {
        
        
        childVcs.append(HomeRecommendViewController())
        childVcs.append(HomeTVViewController())
        childVcs.append(HomeMovieViewController())
        childVcs.append(HomeVMovieViewController())
        childVcs.append(HomeVarietyViewController())
        childVcs.append(HomeAnimViewController())
        childVcs.append(HomeChildViewController())
        childVcs.append(HomeDocuViewController())
        childVcs.append(HomeWarViewController())
        childVcs.append(HomeLoveViewController())
        childVcs.append(HomeGuZhuangViewController())
        childVcs.append(HomeWuYeViewController())
        
        for index in 0..<childVcs.count {
            childVcs[index].title = titles[index]
        }
        
    }
    
    
    
    func rightClick() {
        
    }
    
    func localClick() {
        
    }
    func historyClick() {
        
        let vc = HistoryViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func searchClick() {
        
    }
    func moreClick() {
        
    }
    
}








