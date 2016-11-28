//
//  VIPFunnyViewController.swift
//  kankan
//
//  Created by Xin on 16/10/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class VIPFunnyViewController: VIPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        url = VIPFunnyUrl
        loadData()
        configUI()
    }

   
}
