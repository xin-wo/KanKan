//
//  HotViewController.swift
//  kankan
//
//  Created by Xin on 16/10/19.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HotViewController: UIViewController, WXNavigationProtocol,PageTitleViewDelegate, PageContentViewDelegate {
   
    //索引栏视图
    lazy var titleView: PageTitleView = {
        let titleView = PageTitleView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: 40), titiles: ["精选", "美女", "搞笑", "社会"])
        
        return titleView
    }()
    
    lazy var contentPageView: PageContentView = {
        // 确定所有子视图控制器
        var childVcs: [UIViewController] = []
        let vc1 = SelectedViewController()
        vc1.statusBarHidenClosure = { (bool) in
            UIApplication.sharedApplication().setStatusBarHidden(bool, withAnimation: .None)

        }
        let vc2 = BeautyViewController()
        vc2.statusBarHidenClosure = { (bool) in
            UIApplication.sharedApplication().setStatusBarHidden(bool, withAnimation: .None)
        }
        let vc3 = JokeViewController()
        vc3.statusBarHidenClosure = { (bool) in
            UIApplication.sharedApplication().setStatusBarHidden(bool, withAnimation: .None)
        }
        let vc4 = VideoViewController()
        vc4.statusBarHidenClosure = { (bool) in
            UIApplication.sharedApplication().setStatusBarHidden(bool, withAnimation: .None)
        }
        childVcs.append(vc1)
        childVcs.append(vc2)
        
        childVcs.append(vc3)
        childVcs.append(vc4)
        
        let contentView = PageContentView(frame: CGRect(x: 0, y: 104, width: UIScreen.mainScreen().bounds.width, height: screenHeight-148), childVcS: childVcs, parentVc: self)
        
        return contentView
    }()
    
    var currentBtn: UIButton!
    var childVcs: [UIViewController] = []
    var isStatusBarHiden = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationBar()
        

    }

   
    
    func configNavigationBar() {
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        addTitle("热点")
        addBottomImage()
        
        titleView.delegate = self
        self.view.addSubview(titleView)
        contentPageView.delegate = self
        self.view.addSubview(contentPageView)

    }
   
}
//MARK： 实现索引栏协议方法
extension HotViewController {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setContentWith(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
    }
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        contentPageView.setCurrentIndex(selectedIndex)
        
    }
}





