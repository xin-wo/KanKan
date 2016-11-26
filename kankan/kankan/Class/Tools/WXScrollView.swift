//
//  WXScrollView.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import Kingfisher

let WIDTH = UIScreen.mainScreen().bounds.width

//三个imageView实现轮播页
class WXScrollView: UIView,UIScrollViewDelegate{
    //点击事件
    var jumpClosure: (Int -> Void)?
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var imageArray: [String]!
    var timer: NSTimer!
    //上一张图片
    var preImageView: UIImageView!
    //当前图片
    var nextImageView: UIImageView!
    //下一张图片
    var currentImageView: UIImageView!
    
    var currentPage:Int!
    var bottomView: UIView!
    var bottomLabel: UILabel!
    var textArray: [String]!
    
    var viewWidth:CGFloat {
        return self.frame.size.width
    }
    
    var viewHeight:CGFloat {
        return self.frame.size.height
    }
    
    
    init(frame: CGRect, imageNames: [String], textString: [String]?) {
        super.init(frame: frame)
        self.imageArray = imageNames
        self.textArray = textString
        configView()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //自动切换下一张图片
    func timeRun() {
        UIView.animateWithDuration(0.3, animations: { 
            [unowned self] in
            self.scrollView.contentOffset = CGPoint(x: WIDTH*2, y: 0)
            }, completion: {[unowned self] (b) in
                self.scrollViewDidEndDecelerating(self.scrollView)
            })
    }
    
    func configView() {
        if imageArray.count <= 1{
            return
        }
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.pagingEnabled = true
    
        self.addSubview(scrollView)
        
        preImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        scrollView.addSubview(preImageView)
        
        currentImageView = UIImageView(frame: CGRect(x: viewWidth, y: 0, width: viewWidth, height: viewHeight))
        currentImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        currentImageView.addGestureRecognizer(tap)

        scrollView.addSubview(currentImageView)
        
        nextImageView = UIImageView(frame: CGRect(x: 2*viewWidth, y: 0, width: viewWidth, height: viewHeight))
        scrollView.addSubview(nextImageView)
        
        scrollView.contentSize = CGSize(width: 3*viewWidth, height: viewHeight)
        scrollView.contentOffset = CGPoint(x: viewWidth, y: 0)
        scrollView.delegate = self
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(timeRun), userInfo: nil, repeats: false)
        
        currentPage = 0
        preImageView.kf_setImageWithURL((NSURL(string: imageArray[imageArray.count-1])), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        currentImageView.kf_setImageWithURL((NSURL(string: imageArray[0])), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        nextImageView.kf_setImageWithURL((NSURL(string: imageArray[1])), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        
        
        bottomView = UIView(frame: CGRect(x: 0, y: self.frame.size.height-30, width: WIDTH, height: 30))
        bottomView.layer.opacity = 0.8
        bottomView.backgroundColor = UIColor.blackColor()
        
        self.addSubview(bottomView)
        
        bottomLabel = UILabel(frame: CGRect(x: 5, y: 0, width: WIDTH-130, height: 30))
        bottomLabel.textColor = UIColor.whiteColor()
        bottomLabel.font = UIFont.boldSystemFontOfSize(13)
        bottomView.addSubview(bottomLabel)
        
        pageControl = UIPageControl(frame: CGRect(x: WIDTH-90, y: 0, width: 50, height: 30))
        pageControl.numberOfPages = imageArray.count
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        bottomView.addSubview(pageControl)

        bottomLabel.text = textArray[currentPage]
        
    }
    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(timeRun), userInfo: nil, repeats: false)
        if scrollView.contentOffset.x == 2 * viewWidth{
            
            currentPage = (currentPage+1) % imageArray.count
        }else if scrollView.contentOffset.x == 0{
            
            currentPage = (currentPage - 1 + imageArray.count) % imageArray.count
        }
        preImageView.kf_setImageWithURL(NSURL(string: imageArray[(currentPage - 1 + imageArray.count) % imageArray.count]))
        
        currentImageView.kf_setImageWithURL(NSURL(string: imageArray[currentPage]))
        
        nextImageView.kf_setImageWithURL(NSURL(string: imageArray[(currentPage + 1) % imageArray.count]))
        pageControl.currentPage = currentPage
        bottomLabel.text = textArray[currentPage]
        scrollView.contentOffset = CGPoint(x: viewWidth, y: 0)
    }
    //tap传值
    func tapAction() {
        jumpClosure!(currentPage)
      
    }
    
}
