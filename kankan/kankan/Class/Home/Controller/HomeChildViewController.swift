//
//  HomeChildViewController.swift
//  kankan
//
//  Created by Xin on 16/10/31.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeChildViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        url = homeChildrenUrl
        moreUrl = homeAllChildUrl
        categoryString = "亲子乐园"
        loadMoreData()
        loadData()
        configUI()
    }


}
