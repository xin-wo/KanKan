//
//  HomeVarietyViewController.swift
//  kankan
//
//  Created by Xin on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeVarietyViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        url = homeVarietyUrl
        moreUrl = homeAllVarietyUrl
        categoryString = "综艺片库"
        loadMoreData()
        loadData()
        configUI()
    
    }

   
    
}
