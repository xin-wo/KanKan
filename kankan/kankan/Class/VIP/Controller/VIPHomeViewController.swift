//
//  VIPHomeViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire


class VIPHomeViewController: UIViewController {
    
    // collectionView 懒加载
    lazy var collectionView: UICollectionView = {[unowned self] in
        // 1.创建 layout
        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Vertical
        // 2.创建 collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 140), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        collectionView.registerNib(UINib(nibName: "FooterReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionView.registerClass(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headercell")
        
        collectionView.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellWithReuseIdentifier: "normal")
        
        collectionView.registerNib(UINib(nibName: "OtherReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "other")
        //        collectionView.registerClass(FirstCollectionViewCell.self, forCellWithReuseIdentifier: "first")
        collectionView.registerNib(UINib(nibName: "VIPHomeCell", bundle: nil), forCellWithReuseIdentifier: "VIPHomeCellId")
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
        }()
    
    var scrNameArray: [String] = []
    
    var subTitleArray: [String] = ["","","","","",""]
    //轮播页数据
    var dataArray1: [VIPHomeScrModel] = []
    //section1数据
    var dataArray2: [VIPHomeHotAndNewModel] = []
    //section2数据
    var dataArray3: [VIPHomeHotAndNewModel] = []
    //其余section数据
    var dataArray4: [VIPHomeModulesModel] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configUI()
        
    }
    func configUI() {
        automaticallyAdjustsScrollViewInsets = false
        collectionView.showsVerticalScrollIndicator = false
        view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        
    }
    func loadData() {
        Alamofire.request(.GET, VIPRecUrl).responseJSON { [unowned self] (response) in
            if response.result.error == nil {
                let keyArray = ["headlinePics", "newRelease", "hotVodRank", "modules"]
                for i in 0...3 {
                    let array = (response.result.value as! NSDictionary)["data"]![keyArray[i]] as! [AnyObject]
                    for dic in array {
                        
                        if i == 0 {
                            let model = VIPHomeScrModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray1.append(model)
                            self.scrNameArray.append(model.image)
                        } else if i == 1 {
                            let model = VIPHomeHotAndNewModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray2.append(model)
                        } else if i == 2 {
                            let model = VIPHomeHotAndNewModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray3.append(model)
                            
                        } else if i == 3 {
                            let model = VIPHomeModulesModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray4.append(model)
                        }
                    }
                    
                }
                self.collectionView.reloadData()
                
            }
            
            
        }
        
        
    }
    
  
    
}

//MARK： UICollectionView代理
extension VIPHomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return 3
        } else {
            if dataArray4.count == 0 {
                return 0
            } else {
                return dataArray4[section-3].movies.count
            }
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VIPHomeCellId", forIndexPath: indexPath) as! VIPHomeCell
        
        if indexPath.section == 0 {
            
            return cell
        } else if indexPath.section == 1 {
            if dataArray2.count != 0 {
                let model = dataArray2[indexPath.row]
                
                cell.posterImage.kf_setImageWithURL((NSURL(string: model.image)), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                cell.descLabel.text = model.subTitle
                cell.rankLabel.text = model.score
                cell.titleLabel.text = model.title
                
                return cell
                
            }
            
        } else if indexPath.section == 2 {
            if dataArray3.count != 0 {
                let model = dataArray3[indexPath.row]
                cell.posterImage.kf_setImageWithURL((NSURL(string: model.image)), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                cell.descLabel.text = model.subTitle
                cell.rankLabel.text = model.score
                cell.titleLabel.text = model.title
                
                return cell
            }
            
        } else if indexPath.section == 3 {
            if dataArray4.count != 0 {
                let model = dataArray4[0].movies[indexPath.row]
                cell.posterImage.kf_setImageWithURL((NSURL(string: model.image)), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                cell.descLabel.text = model.subTitle
                cell.rankLabel.text = model.score
                cell.titleLabel.text = model.title
                return cell
            }
            
            
        } else if indexPath.section == 4 {
            if dataArray4.count != 0 {
                let model = dataArray4[1].movies[indexPath.row]
                cell.posterImage.kf_setImageWithURL((NSURL(string: model.image)), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                cell.descLabel.text = model.subTitle
                cell.rankLabel.text = model.score
                cell.titleLabel.text = model.title
                
                return cell
            }
        } else {
            if dataArray4.count != 0 {
                let model = dataArray4[2].movies[indexPath.row]
                cell.posterImage.kf_setImageWithURL((NSURL(string: model.image)), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                cell.descLabel.text = model.subTitle
                cell.rankLabel.text = model.score
                cell.titleLabel.text = model.title
                
                return cell
            }
            
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            if indexPath.section == 0 {
               
                let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headercell", forIndexPath: indexPath) as! HeaderReusableView
                header.setImages(scrNameArray, textString: subTitleArray)
                header.jumpClosure = { [unowned self] (index) in
                    print("您点击的是第\(index)张图片,视频Id为:\(self.dataArray1[index].movieId)(视频地址已加密)")
                    
                    
            }
                
                return header
            } else if indexPath.section == 1 {
                let other = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "other", forIndexPath: indexPath) as! OtherReusableView
                other.categoryLabel.text = "新片首发"
                return other
            } else if indexPath.section == 2 {
                let other = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "other", forIndexPath: indexPath) as! OtherReusableView
                other.categoryLabel.text = "热播排行"
                return other
            } else {
                let other = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "other", forIndexPath: indexPath) as! OtherReusableView
                if dataArray4.count != 0 {
                    other.categoryLabel.text = dataArray4[(indexPath.section-1)%(dataArray4.count)].moduleName
                    
                }
                return other
                
            }
            
        
            
        } else {
            
            let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
            
            return footer
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (screenWidth-20)/3, height: (screenHeight-100)/3)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: screenWidth, height: (screenHeight-100)/3)
        }
        return CGSize(width: screenWidth, height: 30)
    }
    
    
    /*返回第section组collectionView尾部视图的尺寸
     
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize()
        }
        return CGSize(width: screenWidth, height: 1)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    //页面跳转
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let VC = DetailViewController()
        VC.URLString = "http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4"
        VC.title = "蝙蝠侠大战超人"
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
}









