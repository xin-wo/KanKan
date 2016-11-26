//
//  HomeLoveViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/31.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeLoveViewController: HomeOtherBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        url = homeLoveUrl
        loadData()
        configUI()
    }

    
}
