//
//  CollectionView+ScrollView.swift
//  kankan
//
//  Created by Xin on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//


import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

class PageContentView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // 1.定义获取需要的数据
    var progress: CGFloat!
    var sourceIndex: Int!
    var targetIndex: Int!
    
    
    
    var isForbidScrollDelegate: Bool = false
    private var childVcs: [UIViewController] = []
    private weak var parentVc: UIViewController!
    private var startOffsetX: CGFloat = 0 // 默认偏移量
    weak var delegate: PageContentViewDelegate?
    
    // collectionView 懒加载
    lazy var collectionView: UICollectionView = {[unowned self] in
        // 1.创建 layout
        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        // 2.创建 collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.pagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        //        collectionView.isScrollEnabled = false
        
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
        return collectionView
        }()
    
    
    init(frame: CGRect, childVcS: [UIViewController], parentVc: UIViewController) {
        self.childVcs = childVcS
        self.parentVc = parentVc
        super.init(frame: frame)
        
        configUI()
    }
    
    func configUI() {
        
        // 1.将子控制器添加到父控制器
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        
        // 2.添加 collectionView
        self.addSubview(collectionView)
        collectionView.frame = self.bounds
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:UICollectionViewDataSource&Delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return self.bounds.size
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        // 2.判断是左滑还是右滑
        if startOffsetX > scrollView.contentOffset.x {
            
            
            // 右滑
            // 1.计算 progress
            progress = 1 - (scrollView.contentOffset.x/self.collectionView.frame.size.width - floor(scrollView.contentOffset.x/self.collectionView.frame.size.width))
            // 2.计算 targetIndex
            targetIndex = Int(scrollView.contentOffset.x/self.collectionView.frame.size.width)
            // 3.计算 sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            // 4.如果完全划过去
            if startOffsetX - scrollView.contentOffset.x == scrollView.frame.size.width {
                progress = 1
                //                sourceIndex = targetIndex
            }
            
            
            
        }else if startOffsetX < scrollView.contentOffset.x {
//            print("左滑")
            // 左滑
            // 1.计算 progress (floor() 取整函数)
            progress = scrollView.contentOffset.x/self.collectionView.frame.size.width - floor(scrollView.contentOffset.x/self.collectionView.frame.size.width)
            // 2.计算 sourceIndex
            sourceIndex = Int(scrollView.contentOffset.x/self.collectionView.frame.size.width)
            // 3.计算 targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >=  childVcs.count {
                targetIndex = childVcs.count - 1
            }
            // 4.如果完全划过去
            if scrollView.contentOffset.x - startOffsetX == scrollView.frame.size.width {
                progress = 1
                targetIndex = sourceIndex
                sourceIndex = sourceIndex-1
            }
        }else {
            //            targetIndex = sourceIndex
            progress = 0
        }
//        print(startOffsetX)
//        print("progress:\(progress),sourceIndex:\(sourceIndex),targetIndex:\(targetIndex)")
//        print(scrollView.contentOffset.x)
        
        // 3.将progress/sourceIndex/targetIndex 传递给 titleView
        delegate?.pageContentView(self, progress: progress!, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建 cell
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        collectionViewCell.contentView.addSubview(childVcs[indexPath.row].view)
        
        childVcs[indexPath.item].view.frame = self.bounds
        return collectionViewCell
    }
    
}
extension PageContentView {
    func setCurrentIndex(index: Int) {
        // 1. 记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        // 2.滚动到正确位置
        collectionView.setContentOffset(CGPoint(x: collectionView.frame.size.width*CGFloat(index), y: 0), animated: false)
    }
}
