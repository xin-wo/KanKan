//
//  HomeMovieViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeMovieViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        url = homeMovieUrl
        moreUrl = homeAllMovieUrl
        categoryString = "电影片库"
        loadMoreData()
        loadData()
        configUI()
        
        
    }

   
}
