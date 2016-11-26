//
//  HomeBaseReusableView.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/28.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeBaseReusableView: UICollectionReusableView {

    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBOutlet weak var moreLabel: UILabel!
    
    
    var moreJumpClosure: (() -> ())!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action:#selector(clickLabel))
        moreLabel.addGestureRecognizer(tap)
        
        
    }
    func clickLabel() {
       
        moreJumpClosure()
    }
    
}
