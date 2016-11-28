//
//  VIPViewController.swift
//  kankan
//
//  Created by Xin on 16/10/19.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class VIPViewController: UIViewController, WXNavigationProtocol {
    
    var childVcs = [UIViewController]()
    
    let titles:[String] = ["首页", "全部", "动作", "喜剧", "爱情", "科幻", "灾难", "恐怖", "悬疑", "魔幻", "战争", "罪案", "惊悚", "动画", "伦理", "纪录", "剧情"]
    override func prefersStatusBarHidden() -> Bool {
        
        return false
    }
   
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
        addTitle("VIP影院")
        addBottomImage()
        
        
    }
    
    //配置scrollview
    func configScrollView()  {
        
        childVcs.append(VIPHomeViewController())
        childVcs.append(VIPAllViewController())
        childVcs.append(VIPActViewController())
        childVcs.append(VIPFunnyViewController())
        childVcs.append(VIPLoveViewController())
        childVcs.append(VIPScienceViewController())
        childVcs.append(VIPDisasterViewController())
        childVcs.append(VIPTerrifyViewController())
        childVcs.append(VIPSuspenseViewController())
        childVcs.append(VIPMagicViewController())
        childVcs.append(VIPWarViewController())
        childVcs.append(VIPSinViewController())
        childVcs.append(VIPPanicViewController())
        childVcs.append(VIPAnimViewController())
        childVcs.append(VIPRelationViewController())
        childVcs.append(VIPDocuViewController())
        childVcs.append(VIPStoryViewController())
        
        for index in 0..<childVcs.count {
            childVcs[index].title = titles[index]
        }
        
    }
}






