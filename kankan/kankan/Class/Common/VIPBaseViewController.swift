//
//  VIPBaseViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import MJRefresh
import Kingfisher
import Alamofire

class VIPBaseViewController: UIViewController, WXCollectionViewProtocol {
    
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
        collectionView.registerNib(UINib(nibName: "VIPHomeCell", bundle: nil), forCellWithReuseIdentifier: "VIPHomeCellId")
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
        }()
    
    var dataArray: [VIPModel] = []
    var url = ""
    var currentPage = 1
    
    var hideStatusBarClosure: ((Bool) -> (Void))!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.showsVerticalScrollIndicator = false
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
    func loadData() {
        Alamofire.request(.GET, String(format: url, currentPage)).responseJSON { [unowned self] (response) in
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.mj_footer.endRefreshing()
            if self.currentPage == 1 {
                self.dataArray.removeAll()
            }
            if response.result.error == nil {
                
                let array = (response.result.value as! NSDictionary)["data"]!["movieResultList"] as! [AnyObject]
                for dic in array {
                    let model = VIPModel()
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    self.dataArray.append(model)
                }
                
                self.collectionView.reloadData()
                
            }
            
        }
        
    }
    
    
    
    
}
//MARK: UICollectionView代理

extension VIPBaseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (screenWidth-20)/3, height: (screenHeight-50)/3)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return dataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VIPHomeCellId", forIndexPath: indexPath) as! VIPHomeCell
        
        let model = dataArray[indexPath.row]
        
      
        cell.posterImage.kf_setImageWithURL(NSURL(string: model.image), placeholderImage: UIImage(named: "default_poster_250_350"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        cell.rankLabel.text = model.movieScore
        cell.titleLabel.text = model.movieName
        cell.descLabel.text = "正片"
       
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
    }
    
    //跳转web页面
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
//        let headerUrl = "http://m.vip.kankan.com/play.html?movieid="
//        let footerUrl = "&fref=android"
//        let movieid = "\(dataArray[indexPath.row].movieId)"
//        let urlString = headerUrl+movieid+footerUrl
        
        let VC = DetailViewController()
        VC.URLString = "http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4"
        VC.title = "蝙蝠侠大战超人"
        VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(VC, animated: true)
         
    }

}


