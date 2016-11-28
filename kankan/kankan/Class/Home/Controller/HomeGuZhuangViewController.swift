//
//  HomeGuZhuangViewController.swift
//  kankan
//
//  Created by Xin on 16/10/31.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeGuZhuangViewController: HomeOtherBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        url = homeGuZhuangUrl
        loadData()
        configUI()
    }

   
}
