//
//  HomeRecommendViewController.swift
//  kankan
//
//  Created by Xin on 16/10/20.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import MJRefresh



class HomeRecommendViewController: UIViewController {
    
    // collectionView 懒加载
    lazy var collectionView: UICollectionView = {[unowned self] in
        // 1.创建 layout
        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Vertical
        // 2.创建 collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-140), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        collectionView.registerNib(UINib(nibName: "FooterReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionView.registerClass(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellWithReuseIdentifier: "normal")
        
        collectionView.registerNib(UINib(nibName: "OtherReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "other")
//        collectionView.registerClass(FirstCollectionViewCell.self, forCellWithReuseIdentifier: "first")
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
        }()
    //索引栏数据
    var dataArray1: [HomeBkCgModel] = []
    //影片内容数据
    var dataArray2: [HomeBsModel] = []
    //轮滑页数据
    var dataArray3: [HomeScrModel] = []
    //正确数据顺序
    var dataArray: [HomeBsModel] = []

    //轮滑页图片地址
    var scrNameArray: [String] = []
    //轮滑页图片标题
    var subTitleArray: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        loadData()
        
    }
    
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        
    }
    
    
    func loadData() {
       
        Alamofire.request(.GET, homeRecUrl).responseJSON { [unowned self] (response) in
            if response.result.error == nil {
                let keyArray = ["block_config", "blocks", "top_block"]
                for i in 0...2 {
                    let array = (response.result.value as! NSDictionary)[keyArray[i]] as! [AnyObject]
                    var j = -1
                    let indexArray = [5, 8, 13, 14]
                    
                    xx: for dic in array {
                        j += 1
                        if i == 0 {
                            let model = HomeBkCgModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray1.append(model)
                        } else if i == 1 {
                            for i in indexArray {
                                if j == i {
                                    continue xx
                                }
                            }
                            let model = HomeBsModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray2.append(model)
                        } else if i == 2 {
                            let model = HomeScrModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray3.append(model)
                            self.scrNameArray.append(model.poster)
                            self.subTitleArray.append(model.subtitle)
                        }
                    }
                    
                }
                
                self.collectionView.reloadData()
            }
            self.getDataArray()
            
        }
        
    }
    //重新排列数据
    func getDataArray() {
        
        for j in 0..<dataArray1.count {
            for i in 0..<dataArray1.count {
                
                let BsModel = dataArray2[i]
                if dataArray1[j].block_id == BsModel.block_id {
                    dataArray.append(dataArray2[i])
                }
            }
        }
    }
    
    
}

//MARK: UICollectionView代理
extension HomeRecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataArray2.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            if dataArray.count == 0 {
                return 0
            } else {
                
                return dataArray[section-1].data.count
                
            }
        }
        
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("normal", forIndexPath: indexPath) as! NormalCell
        
        
        if indexPath.section == 0 {
            
            return cell
        } else {
        
            if dataArray.count != 0 {
                let model = dataArray[indexPath.section - 1].data[indexPath.row]
                cell.posterImage.kf_setImageWithURL(NSURL(string: model.poster), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                cell.titleLabel.text = model.title
                cell.detailLabel.text = model.subtitle
                cell.descLabel.text = model.kankan_type
                cell.rankLabel.text = model.rating
                if model.is_vip != nil {
                    if model.is_vip == "true" {
                        cell.VIPLabel.text = "VIP"
                        cell.VIPLabel.textColor = UIColor.whiteColor()
                        cell.VIPLabel.backgroundColor = UIColor.redColor()
                    } else {
                        cell.VIPLabel.text = ""
                        cell.VIPLabel.backgroundColor = UIColor.clearColor()
                    }
                    
                } else {
                    cell.VIPLabel.text = ""
                    cell.VIPLabel.backgroundColor = UIColor.clearColor()
                }
                
                
            }
            
            
            
            return cell
            }
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! HeaderReusableView
                header.setImages(scrNameArray, textString: subTitleArray)
                
                header.jumpClosure = {
                    currentPage in
                    if self.dataArray3[currentPage].ad_url != "" {
                        print("您当前点击的是第\(currentPage)页,是广告，广告地址为\(self.dataArray3[currentPage].ad_url)")
                    } else {
                        print("您当前点击的是第\(currentPage)页,是视频，视频Id为:\(self.dataArray3[currentPage].movieid)(视频地址已加密)")
                    }
                    
                }
                
                return header
            }
            let other = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "other", forIndexPath: indexPath) as! OtherReusableView
            if indexPath.section == 0 {
                return other
            }
            let model = dataArray1[indexPath.section-1]
            
            
            other.categoryLabel.text = model.block_title
            var allWords: String = ""
            var j = model.hot_words!.count - 1
            for i in 0..<model.hot_words!.count {
                if i == 0 {
                    allWords = allWords + model.hot_words![j].words
                } else {
                    allWords = allWords + " / " + model.hot_words![j].words
                }
                
                j -= 1
            }
            other.moreLabel.text = allWords
            
            
            return other
            
            
        } else {
            
            let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
            
            return footer
            
        }

        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        if dataArray[indexPath.section-1].data.count % 2 == 1  {
            if indexPath.row == 0 {
                return CGSize(width: screenWidth-10, height: (screenHeight-100)/3)
            }
            
        }
        
        if indexPath.section == 12 {
            return CGSize(width: screenWidth-10, height: (screenHeight-150)/3)
        }
       
        return CGSize(width: (screenWidth-10)/2, height: (screenHeight-180)/3)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: screenWidth, height: (screenHeight-100)/3)
        }
        return CGSize(width: screenWidth, height: 25)
    }
    
    
    /*返回第section组collectionView尾部视图的尺寸
     
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            
            return CGSize()
            
        }
        return CGSize(width: screenWidth, height: 10)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
       
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    //跳转页面
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }
}















