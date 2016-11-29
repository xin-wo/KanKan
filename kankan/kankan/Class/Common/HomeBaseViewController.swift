
//
//  BaseViewController.swift
//  kankan
//
//  Created by Xin on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import MJRefresh

class HomeBaseViewController: UIViewController, WXCollectionViewProtocol {

    // collectionView 懒加载
    lazy var collectionView: UICollectionView = {[unowned self] in
        // 1.创建 layout
        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Vertical
        // 2.创建 collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 143), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
//                collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        collectionView.registerNib(UINib(nibName: "FooterReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionView.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellWithReuseIdentifier: "normal")
        
        collectionView.registerNib(UINib(nibName: "OtherReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "other")
        collectionView.registerNib(UINib(nibName: "HomeBaseReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "homeBaseReusableViewId")
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
        }()
    //索引栏数据
    var dataArray1: [HomeBkCgModel] = []
    //影片内容数据
    var dataArray2: [HomeBsModel] = []
    //单个电影数据
    var dataArray3: [HomeSingleModel] = []
    //所有电影数据
    var dataArray: [HomeAllModel] = []
    //首次加载地址
    var url = ""
    //刷新加载更多地址
    var moreUrl = ""
    //刷新加载更多section名称
    var categoryString = ""
    
    var currentPage = 1
    
    var moreCurrentPage = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        //下拉刷新
        addRefresh(collectionView, header: { [unowned self] in
            self.moreCurrentPage = 1
            self.loadMoreData()
            
        }) { [unowned self] in
            self.moreCurrentPage += 1
            self.loadMoreData()
        }
    }
    
    
    //加载首次请求数据
    func loadData() {
        
        Alamofire.request(.GET, url).responseJSON { [unowned self] (response) in
            if response.result.error == nil {
                let keyArray = ["block_config", "blocks"]
                for i in 0...1 {
                    let array = (response.result.value as! NSDictionary)[keyArray[i]] as! [AnyObject]
                    for dic in array {
                        if i == 0 {
                            let model = HomeBkCgModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray1.append(model)
                        } else if i == 1 {
                            let model = HomeBsModel()
                            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                            self.dataArray2.append(model)
                        }
                    }
                    
                }
                
                self.collectionView.reloadData()
                
            }
            
        }
        
    }
    
  
    
    //跳转到web页面
    func loadWeb(atIndaxPath indexPath: NSIndexPath) {
        
        if indexPath.section < dataArray2.count {
            var webUrl: String = ""
            let movieId = dataArray2[indexPath.section].data[indexPath.row].movieid
            //单个电影的json数据地址
            let singleUrl = homeSingleJson + movieId
            print(singleUrl)
            Alamofire.request(.GET, singleUrl).responseJSON { [unowned self] (response) in
                if response.result.error == nil {
                
//                    print((response.result.value as! NSDictionary)["data"] as! NSDictionary)
                    if (response.result.value as! NSDictionary)["data"] != nil {
                        let dic = (response.result.value as! NSDictionary)["data"]! as! NSDictionary
                        let model = HomeSingleModel()
                        model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                        
                        self.dataArray3.append(model)
                        
                    }
                    
                }
                if self.dataArray3.count != 0 {
                    
                    let headerUrl = "http://vod.kankan.com/v/"
                    let footerUrl = ".shtml"
                    let remainder = self.dataArray3[0].id
                    
                    let smallUrl = self.dataArray3[0].screen_shot
                    let impUrl = smallUrl.substringToIndex(smallUrl.startIndex.advancedBy(9))
                    //单个电影web地址
                    webUrl = headerUrl+impUrl+remainder+footerUrl
                    
                    print(webUrl)
                    self.dataArray3.removeAll()
                    //跳转web页面
                    let webVC = WebViewController()
                    webVC.urlString = webUrl
                    webVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(webVC, animated: true)
                    
                }
                
            }
            
        }
    
    }
    //加载刷新数据
    func loadMoreData() {
        Alamofire.request(.GET, String(format: moreUrl, moreCurrentPage)).responseJSON { [unowned self] (response) in
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()
            if self.moreCurrentPage == 1 {
                self.dataArray.removeAll()
            }
            
            if response.result.error == nil {
                let array = (response.result.value as! NSDictionary)["data"]!["items"] as! [AnyObject]
                for dic in array {
                    let model = HomeAllModel()
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    self.dataArray.append(model)
                }
                
            }
            self.collectionView.reloadData()
        }
        
    }
    
    
}
//MARK:UICollectionView代理

extension HomeBaseViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if dataArray.count == 0 {
            return dataArray2.count
        }
        return dataArray2.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataArray2.count != 0{
            if dataArray.count != 0 {
                if section == dataArray2.count {
                    return dataArray.count
                } else {
                    return dataArray2[section].data.count
                }
            }
        }
    
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("normal", forIndexPath: indexPath) as! NormalCell
        if indexPath.section == dataArray2.count {
            let model = dataArray[indexPath.row]
            cell.descLabel.text = model.attract
            cell.detailLabel.text = model.label
                cell.posterImage.kf_setImageWithURL(NSURL(string:"http://img.movie.kanimg.kankan.com/gallery"+model.poster), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            cell.rankLabel.text = "\(model.score)"
            cell.titleLabel.text = model.title
            cell.layoutIfNeeded()
            return cell
            
        } else {
            let model = dataArray2[indexPath.section].data[indexPath.row]
            cell.descLabel.text = model.kankan_type
            cell.detailLabel.text = model.subtitle
            cell.posterImage.kf_setImageWithURL(NSURL(string: model.poster), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            cell.rankLabel.text = model.rating
            cell.titleLabel.text = model.title
            
            return cell
        }
       
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let other = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "homeBaseReusableViewId", forIndexPath: indexPath) as! HomeBaseReusableView
            if indexPath.section != dataArray1.count {
                if dataArray1[indexPath.section].hot_words!.count != 0 {
                    other.moreJumpClosure = { [unowned self] in
                        let footerString = "os,az/osver,6.0/productver,5.3.0.65/page,%d/pernum,12/"
                        let headerString = self.dataArray1[indexPath.section].hot_words![indexPath.row].action_target[0].url
                        let urlString = headerString + footerString
                        let JVC = JumpViewController()
                        JVC.url = urlString
                        print(urlString)
                        JVC.title = self.dataArray1[indexPath.section].block_title
                        JVC.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(JVC, animated: true)
                    }

            }
            
            }
            if indexPath.section == dataArray1.count {
                other.categoryLabel.text = categoryString
                
                return other
            } else {
                
                let model = dataArray1[indexPath.section]
                
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
                
            }
            
            
        } else {
            
            let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
            
            return footer
            
        }
   
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: screenWidth, height: 25)
    }
    
    
    /*返回第section组collectionView尾部视图的尺寸
     
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: screenWidth, height: 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        loadWeb(atIndaxPath: indexPath)
       
        
    }
    
    //item的排列方式
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section < dataArray2.count {
            if dataArray2[indexPath.section].data.count % 2 == 1  {
                if indexPath.row == 0 {
                    return CGSize(width: screenWidth-10, height: (screenHeight-100)/3)
                } else {
                    return CGSize(width: (screenWidth-10)/2, height: (screenHeight-180)/3)
                }
                
            } else if dataArray2[indexPath.section].data.count == 4 {
                return CGSize(width: (screenWidth-10)/2, height: (screenHeight-180)/3)
            }
            
        }
        
        return CGSize(width: (screenWidth-20)/3, height: (screenHeight-100)/3)
        
    }
    

    

}

//MARK: WXCollectionViewProtocol协议
protocol WXCollectionViewProtocol: NSObjectProtocol {
    
    func addRefresh(collecitonView: UICollectionView, header: (() -> ())?, footer: (() -> ())?)
}

//拓展WXCollectionViewProtocol
extension WXCollectionViewProtocol where Self: UIViewController {
    func addRefresh(collecitonView: UICollectionView, header: (() -> ())?, footer: (() -> ())?) {
        
        if header != nil {
            collecitonView.mj_header = MJRefreshNormalHeader(refreshingBlock: header)
        }
        
        if footer != nil {
            collecitonView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: footer)
        }
    }
    
}
