//
//  HomeTVViewController.swift
//  kankan
//
//  Created by Xin on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import MJRefresh

class HomeTVViewController: HomeBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url = homeTVUrl
        moreUrl = homeAllTVUrl
        categoryString = "电视剧库"
        configUI()
        loadData()
        loadMoreData()
    }
       
}




