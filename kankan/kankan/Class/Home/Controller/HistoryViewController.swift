//
//  HistoryViewController.swift
//  kankan
//
//  Created by Xin on 16/11/10.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,WXNavigationProtocol {
    
    
    // collectionView 懒加载
    lazy var collectionView: UICollectionView = {[unowned self] in
        // 1.创建 layout
        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Vertical
        // 2.创建 collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-104), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        collectionView.registerNib(UINib(nibName: "FooterReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionView.registerClass(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.registerNib(UINib(nibName: "HistoryCell", bundle: nil), forCellWithReuseIdentifier: "historyCellId")
        
        collectionView.registerNib(UINib(nibName: "OtherReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "other")
        //        collectionView.registerClass(FirstCollectionViewCell.self, forCellWithReuseIdentifier: "first")
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
        }()

    
    var dataArray = [HotModel]()
    
    var isEditting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configUI()
    }
    
    func configUI() {
//        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(collectionView)
        self.title = "播放记录"
        
        addBarButton("编辑", postion: .right, select: #selector(editAction))
        addBarButton(imageName: "app_nav_back_normal", bgImageName: "app_nav_back_clicked", postion: .left, select: #selector(backAction))
       
        
    }
    func loadData() {
        dataArray = DataBase.shareDataBase.selectNum(20) ?? []
        self.collectionView.reloadData()
    }
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func editAction() {
        self.navigationItem.rightBarButtonItems?.removeLast()
        addBarButton("完成", postion: .right, select: #selector(completeAction))
         NSNotificationCenter.defaultCenter().postNotificationName("startEdit", object: self)
        isEditting = true
        
        
    }
    func completeAction() {
        self.navigationItem.rightBarButtonItems?.removeLast()
        addBarButton("编辑", postion: .right, select: #selector(editAction))
         NSNotificationCenter.defaultCenter().postNotificationName("endEdit", object: self)
        isEditting = false
    }
}

//MARK: UICollectionView代理
extension HistoryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("historyCellId", forIndexPath: indexPath) as! HistoryCell
        let model = dataArray[indexPath.row]
        cell.imageIcon.kf_setImageWithURL(NSURL(string: model.img), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        cell.titleLabel.text = model.title
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        longPress.minimumPressDuration = 1
        longPress.numberOfTouchesRequired = 1
        cell.addGestureRecognizer(longPress)
    
        cell.deleteClosure = { [unowned self] in
            let indexpath = collectionView.indexPathForCell(cell)
            let videoId = self.dataArray[indexpath!.row].videoid
            DataBase.shareDataBase.deleteWithIDcard(ID: videoId)
            self.dataArray.removeAtIndex(indexpath!.row)
            collectionView.deleteItemsAtIndexPaths([indexpath!])
            
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (screenWidth-10)/2, height: (screenHeight-180)/3)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 5, bottom: 0, right: 5)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if isEditting {
            return
        }
        let model = dataArray[indexPath.row]
        let tmpVideoId = "\(model.videoid)"
        let str = tmpVideoId.substringToIndex(tmpVideoId.startIndex.advancedBy(3))
        let webVC = WebViewController()
        webVC.urlString = "http://vod.kankan.com/v/"+str+"/"+tmpVideoId+".shtml"
        print(webVC.urlString)
        webVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(webVC, animated: true)
        
    }
    func longPressAction(longPress: UIGestureRecognizer) {
        if (!isEditting) {
            editAction()
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isEditting {
            NSNotificationCenter.defaultCenter().postNotificationName("startEdit", object: self)
        }
    }
        
}








