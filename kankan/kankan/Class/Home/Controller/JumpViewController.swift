//
//  JumpViewController.swift
//  kankan
//
//  Created by Xin on 16/11/8.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import Kingfisher


class JumpViewController: UIViewController, WXCollectionViewProtocol {
    

    // collectionView 懒加载
    lazy var collectionView: UICollectionView = {[unowned self] in
        // 1.创建 layout
        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Vertical
        // 2.创建 collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //                collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        
        collectionView.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellWithReuseIdentifier: "normal")
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
        }()
    //所有电影数据
    var dataArray: [HomeAllModel] = []
    //单个电影数据
    var dataArray1: [HomeSingleModel] = []
    
    var url = ""
    
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        loadData()
        
    }
    
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false

        self.view.addSubview(collectionView)
        //下拉刷新
        addRefresh(collectionView, header: { [unowned self] in
            self.currentPage = 1
            self.loadData()
            
        }) { [unowned self] in
            self.currentPage += 1
            self.loadData()
        }
    }
    
    //加载所有数据
    func loadData() {
        Alamofire.request(.GET, String(format: url, currentPage)).responseJSON { [unowned self] (response) in
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()
            if self.currentPage == 1 {
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
    //跳转web页面
    func loadWeb(atIndaxPath indexPath: NSIndexPath) {
        
        if indexPath.section < dataArray.count {
            var webUrl: String = ""
            let movieId = "\(dataArray[indexPath.row].id)"
            let singleUrl = homeSingleJson + movieId
            Alamofire.request(.GET, singleUrl).responseJSON { [unowned self] (response) in
                if response.result.error == nil {
                    
                    //                    print((response.result.value as! NSDictionary)["data"] as! NSDictionary)
                    if (response.result.value as! NSDictionary)["data"] != nil {
                        let dic = (response.result.value as! NSDictionary)["data"]! as! NSDictionary
                        let model = HomeSingleModel()
                        model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                        
                        self.dataArray1.append(model)
                        
                    }
                    
                }
                if self.dataArray1.count != 0 {
                    
                    let headerUrl = "http://vod.kankan.com/v/"
                    let footerUrl = ".shtml"
                    let remainder = self.dataArray1[0].id
                    
                    let smallUrl = self.dataArray1[0].screen_shot
                    let impUrl = smallUrl.substringToIndex(smallUrl.startIndex.advancedBy(9))
                    
                    webUrl = headerUrl+impUrl+remainder+footerUrl
                    
                    print(webUrl)
                    self.dataArray1.removeAll()
                    
                    let webVC = WebViewController()
                    webVC.urlString = webUrl
                    webVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(webVC, animated: true)
                    
                }
                
            }
            
        }
        
    }
    
    
}
//MARK: UICollectionView代理
extension JumpViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("normal", forIndexPath: indexPath) as! NormalCell
        
        let model = dataArray[indexPath.row]
        if model.label == "" {
            cell.descLabel.text = "正片"
        } else {
            cell.descLabel.text = model.label
        }
        cell.posterImage.kf_setImageWithURL(NSURL(string:"http://img.movie.kanimg.kankan.com/gallery"+model.poster), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        cell.rankLabel.text = "\(model.score)"
        cell.titleLabel.text = model.title
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (screenWidth-20)/3, height: (screenHeight-50)/3)
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //跳转web页面
        loadWeb(atIndaxPath: indexPath)
    }
    
   
   
}











