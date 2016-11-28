//
//  JokeViewController.swift
//  kankan
//
//  Created by Xin on 16/11/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class JokeViewController: HotBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        url = HotJokeUrl
        configUI()
        loadData()
    }

  
}
