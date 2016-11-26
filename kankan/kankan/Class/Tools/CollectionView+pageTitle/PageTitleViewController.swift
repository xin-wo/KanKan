//
//  PageTitleViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

// class 表示该协议只能被类遵守
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int)
}


private let kLeftMargin: CGFloat = 10
private let kTopMargin: CGFloat = 3

class PageTitleView: UIView {
    
    private var titles: [String] = []
    var titleLabels: [UILabel] = []
    var currentIndex = 0
    weak var delegate: PageTitleViewDelegate?
    
    
    lazy var scrollBlock: UIView = {
        let scrollBlock = UIView()
        scrollBlock.backgroundColor = UIColor.blueColor()
        scrollBlock.layer.cornerRadius = 5
        return scrollBlock
    }()
    
    init(frame: CGRect, titiles: [String]) {
        self.titles = titiles
        super.init(frame: frame)
        
        cinfigUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cinfigUI() {
        self.backgroundColor = UIColor(white: 0.1, alpha: 0.2)
        
        let labelW = (self.frame.size.width-(CGFloat(titles.count+1)*kLeftMargin))/CGFloat(titles.count)
        //滑块和label的高度
        let labelH = self.frame.size.height-CGFloat(2)*kTopMargin
        
       
        
        // 添加滑块
        self.addSubview(scrollBlock)
        
        for i in 0...titles.count-1 {
            let label = UILabel()
            label.text = titles[i]
            label.textAlignment = .Center
            label.textColor = UIColor.blackColor()
            label.tag = i
            label.font = UIFont.systemFontOfSize(18)
            
            label.frame = CGRect(x: kLeftMargin+(kLeftMargin+labelW)*CGFloat(i), y: kTopMargin, width: labelW, height: labelH)
            self.addSubview(label)
            
            label.userInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(labelClick(_:)))
            label.addGestureRecognizer(tapGes)
            
            titleLabels.append(label)
            
            // 设置底线
            let bottomLine = UIView(frame: CGRect(x: 0, y: self.frame.size.height-0.5, width: self.frame.size.width, height: 0.5))
            bottomLine.backgroundColor = UIColor.lightGrayColor()
            self.addSubview(bottomLine)
            
            // 设置滑块位置
            let firstLabel = titleLabels.first
            scrollBlock.frame = (firstLabel?.frame)!
            firstLabel?.textColor = UIColor.whiteColor()
            
        }
        
        
    }
    
    @objc private func labelClick(tap: UITapGestureRecognizer) {
        print(tap.view?.tag)
        let currentLabel = tap.view as! UILabel
        let oldLabel = titleLabels[currentIndex]
        
        if currentLabel.tag != currentIndex {
            currentLabel.textColor = UIColor.whiteColor()
            oldLabel.textColor = UIColor.blackColor()
        }
        currentIndex = currentLabel.tag
        
        scrollBlock.frame = currentLabel.frame
        
        delegate?.pageTitleView(self, selectedIndex: currentLabel.tag)
    }
}

//MARK:对外暴露的方法
extension PageTitleView {
    func setContentWith(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        // 1.取出sourceLabel 和 targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollBlock.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        if progress > 0.5 {
            sourceLabel.textColor = UIColor.blackColor()
            targetLabel.textColor = UIColor.whiteColor()
            currentIndex = targetIndex
        }else {
            targetLabel.textColor = UIColor.blackColor()
            sourceLabel.textColor = UIColor.whiteColor()
            currentIndex = sourceIndex
        }
        
        // 4.记录最新的 index
        
    }
}
