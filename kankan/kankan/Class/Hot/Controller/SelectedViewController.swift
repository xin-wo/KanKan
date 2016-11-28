//
//  SelectedViewController.swift
//  kankan
//
//  Created by Xin on 16/11/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class SelectedViewController: HotBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onDeviceOrientationChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
        url = HotSelectedUrl
        configUI()
        loadData()
    }

   
}
