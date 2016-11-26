//
//  HomeDocuViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/31.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeDocuViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        url = homeDocuUrl
        moreUrl = homeAllDocuUrl
        categoryString = "纪录片片库"
        loadMoreData()
        loadData()
        configUI()
    }

}
