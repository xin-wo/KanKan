//
//  CollectionReusableView.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    var imageNames = [String]()
    var jumpClosure: (Int -> Void)?
    
    
    var scrollView = WXScrollView()
    // 使用提前注册的时候，不用xib定制，可以重写下面方法
    override init(frame: CGRect) {
        super.init(frame: frame)

//        self.backgroundColor = UIColor.brownColor()

        
    }
    
    func setImages(imageNames: [String], textString: [String]) {
        for sub in scrollView.subviews {
            sub.removeFromSuperview()
        }
        scrollView = WXScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: (screenHeight-100)/3), imageNames: imageNames, textString: textString)
        
        scrollView.jumpClosure = jumpClosure
        self.addSubview(scrollView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
}
