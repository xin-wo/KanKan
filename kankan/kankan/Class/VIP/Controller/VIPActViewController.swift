//
//  VIPActViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class VIPActViewController: VIPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        url = VIPActUrl
        loadData()
        configUI()
    }

    
}
