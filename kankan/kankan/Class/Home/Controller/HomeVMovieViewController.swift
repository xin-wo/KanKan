//
//  HomeVMovieViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeVMovieViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        url = homeVMovieUrl
        moreUrl = homeAllVMovieUrl
        categoryString = "网络电影片库"
        loadMoreData()
        configUI()
        loadData()
       
        
    }

    
}
