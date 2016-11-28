//
//  HomeAnimViewController.swift
//  kankan
//
//  Created by Xin on 16/10/31.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeAnimViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        url = homeAnimationUrl
        loadData()
        configUI()
        moreUrl = homeAllAnimUrl
        categoryString = "动漫片库"
        loadMoreData()
       
    }

    
}
