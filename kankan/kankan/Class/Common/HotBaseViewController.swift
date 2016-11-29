//
//  HotBaseViewController.swift
//  kankan
//
//  Created by Xin on 16/11/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import MJRefresh
import SnapKit


class HotBaseViewController: UIViewController,UIScrollViewDelegate,WXTableViewProtocol {

    
    var url = ""
    var hotTableView: UITableView!
    var dataArray: [PlayerModel] = []
    var shareTableView: UITableView!
    var shareView: UIView!
    var blackBgView: UIView!
    var wxPlayer: WXPlayer!
    var currentCell = HotCell()
    var isSmallScreen: Bool = false
    var currentIndexPath: NSIndexPath!
    
    var statusBarHidenClosure: (Bool -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
  
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.releaseWXPlayer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onDeviceOrientationChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        hotTableView = UITableView(frame: CGRect(origin: self.view.frame.origin, size: CGSize(width: screenWidth, height: screenHeight-148)), style: .Plain)
//            CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-148), style: .Plain)
        hotTableView.showsVerticalScrollIndicator = false
        hotTableView.delegate = self
        hotTableView.dataSource = self
        hotTableView.registerNib(UINib(nibName: "HotCell", bundle: nil),  forCellReuseIdentifier: "hotCellId")
        hotTableView.contentMode = .ScaleAspectFill
        
        self.view.addSubview(hotTableView)
      
    }
    
    func loadData() {
        Alamofire.request(.GET, String(format: "http://c.3g.163.com/nc/video/list/%@/y/0-10.html", url)).responseJSON { [unowned self] (response) in
            if response.result.error == nil {
                let array = (response.result.value as! NSDictionary)[self.url]! as! [AnyObject]
                for dic in array {
                    let model = PlayerModel()
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    self.dataArray.append(model)
                }
                self.hotTableView.reloadData()
            }
        }
        
        
    }
    
    func configShareView() {
        blackBgView = UIView(frame: CGRect(x: 0, y: -100, width: screenWidth, height: screenHeight))
        blackBgView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        self.view.addSubview(blackBgView)
        
        self.automaticallyAdjustsScrollViewInsets=false
        self.shareView = UIView(frame: CGRect(x: 50, y: 70, width: screenWidth-100,  height: screenHeight-300))
        self.shareTableView = UITableView(frame:CGRect(x: 0, y: 0, width: shareView.frame.size.width, height: shareView.frame.size.height), style: .Plain)
        self.shareView.addSubview(self.shareTableView)
        self.shareTableView.delegate = self
        self.shareTableView.dataSource = self
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: shareView.frame.size.width, height: 40))
        let titleLabel = UILabel(frame: headerView.frame)
        titleLabel.text = "分享到"
        titleLabel.textAlignment = .Center
        headerView.addSubview(titleLabel)
        let imageView = UIImageView(frame: CGRect(x: 0, y: headerView.frame.size.height-2, width: headerView.frame.size.width, height: 2))
        imageView.image = UIImage(named: "app_nav_separater")
        headerView.addSubview(imageView)
        
        self.shareTableView.tableHeaderView = headerView
        self.shareTableView.registerNib(UINib(nibName: "AlertCell", bundle: nil), forCellReuseIdentifier: "alertCellId")
        self.view.addSubview(self.shareView)
        
    }
    func hideShareView() {

        shareView.removeFromSuperview()
        blackBgView.removeFromSuperview()
    }
    func onDeviceOrientationChange() {
        
        if wxPlayer == nil || wxPlayer.superview == nil {
            return
        }
        
        let orientation = UIDevice.currentDevice().orientation
        
        switch orientation {
        case  .PortraitUpsideDown:
            print("第3个旋转方向---电池栏在下")
        case .Portrait:
            print("第0个旋转方向---电池栏在上")
            if wxPlayer.isFullscreen {
               
                self.toCell()
                
            }
        case .LandscapeLeft:
            print("第2个旋转方向---电池栏在左")
            wxPlayer.isFullscreen = true
            
            self.setNeedsStatusBarAppearanceUpdate()
           
            self.toFullScreenWithInterfaceOrientation(orientation)
        case .LandscapeRight:
            print("第1个旋转方向---电池栏在右")
            wxPlayer.isFullscreen = true
          
            self.setNeedsStatusBarAppearanceUpdate()
            self.toFullScreenWithInterfaceOrientation(orientation)
        default:
            print("我已经分不清方向💫！")
        }
    }
    
    
    func toCell() {
        statusBarHidenClosure(false)
        currentCell = (self.hotTableView.cellForRowAtIndexPath(NSIndexPath(forRow: currentIndexPath.row, inSection: 0)) as? HotCell)!
        wxPlayer.removeFromSuperview()
        UIView.animateWithDuration(0.5, animations:{
            [unowned self] in
            self.wxPlayer.transform = CGAffineTransformIdentity
            self.wxPlayer.frame = self.currentCell.imageIcon.bounds
    
            self.wxPlayer.playerLayer.frame = self.wxPlayer.bounds
            self.currentCell.imageIcon.addSubview(self.wxPlayer)
            self.currentCell.imageIcon.bringSubviewToFront(self.wxPlayer)
            
            self.wxPlayer.topView.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(self.wxPlayer)
                make.right.equalTo(self.wxPlayer)
                make.height.equalTo(40)
                make.top.equalTo(self.wxPlayer)
            })
         
            self.wxPlayer.titleLabel.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(self.wxPlayer.topView).offset(45)
                make.right.equalTo(self.wxPlayer.topView).offset(-45);
                make.center.equalTo(self.wxPlayer.topView)
                make.top.equalTo(self.wxPlayer.topView)
                
            })
          
            self.wxPlayer.bottomView.snp_remakeConstraints { (make) in
                make.height.equalTo(40);
                make.right.equalTo(self.wxPlayer)
                make.bottom.equalTo(self.wxPlayer)
                make.left.equalTo(self.wxPlayer)
            }
            
            self.wxPlayer.closeBtn.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(self.wxPlayer).offset(5)
                make.height.equalTo(30)
                make.width.equalTo(30)
                make.top.equalTo(self.wxPlayer).offset(5)
            })
            self.wxPlayer.loadingView.snp_remakeConstraints(closure: { (make) in
                make.center.equalTo(self.wxPlayer)
                make.width.equalTo(self.wxPlayer)
                make.height.equalTo(30)
            })
            
            
            }) { (bool) in
                self.wxPlayer.isFullscreen = false
                self.setNeedsStatusBarAppearanceUpdate()
                self.isSmallScreen = false
                self.wxPlayer.fullScreenBtn.selected = false
        }
    }
    
    func toFullScreenWithInterfaceOrientation(orientation:UIDeviceOrientation) {
        statusBarHidenClosure(true)
        wxPlayer.removeFromSuperview()
        wxPlayer.transform = CGAffineTransformIdentity
        if orientation == .LandscapeLeft {
            wxPlayer.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        } else if orientation == .LandscapeRight {
            wxPlayer.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        } else if orientation == .Portrait {
            print("=========")
        }
        
        wxPlayer.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        wxPlayer.playerLayer.frame = CGRectMake(0, 0, screenHeight, screenWidth)
        wxPlayer.bottomView.snp_remakeConstraints { (make) in
            make.height.equalTo(40);
            make.top.equalTo(screenWidth-40);
            make.width.equalTo(screenHeight)
            make.left.equalTo(wxPlayer)
        }
     
        wxPlayer.topView.snp_remakeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalTo(wxPlayer)
            make.width.equalTo(screenHeight)
        }
      

        wxPlayer.titleLabel.snp_remakeConstraints { (make) in
            make.left.equalTo(wxPlayer.topView).offset(45)
            make.right.equalTo(wxPlayer.topView).offset(-45)
            make.center.equalTo(wxPlayer.topView)
            make.top.equalTo(wxPlayer.topView)
        }

        wxPlayer.loadFailedLabel.snp_remakeConstraints { (make) in
            make.width.equalTo(kScreenHeight)
            make.center.equalTo(CGPointMake(screenWidth/2-36, -(screenWidth/2)+36))
            make.height.equalTo(30)
        }
        wxPlayer.loadingView.snp_remakeConstraints { (make) in
            make.center.equalTo(CGPointMake(screenWidth/2-37, -(screenWidth/2-37)))
        }
        wxPlayer.progressSlider.snp_makeConstraints { (make) in
            make.left.equalTo(wxPlayer.bottomView).offset(45)
            make.right.equalTo(wxPlayer.bottomView).offset(-45)
            make.center.equalTo(wxPlayer.bottomView)
        }
       
        wxPlayer.loadingProgress.snp_makeConstraints { (make) in
            make.left.right.equalTo(wxPlayer.progressSlider)
            make.center.equalTo(wxPlayer.progressSlider)
        }
      
        wxPlayer.fullScreenBtn.snp_makeConstraints { (make) in
            make.right.equalTo(wxPlayer.bottomView)
            make.bottom.equalTo(wxPlayer.bottomView).offset(-5)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
       
        wxPlayer.closeBtn.snp_makeConstraints { (make) in
            make.left.equalTo(wxPlayer.topView).offset(5)
            make.height.equalTo(30)
            make.top.equalTo(wxPlayer.topView).offset(5)
            make.width.equalTo(30)
        }
        wxPlayer.rightTimeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(wxPlayer.bottomView).offset(45)
            make.right.equalTo(wxPlayer.bottomView).offset(-45)
            make.bottom.equalTo(wxPlayer.bottomView)
        }
        
        UIApplication.sharedApplication().keyWindow?.addSubview(wxPlayer)
        
        wxPlayer.fullScreenBtn.selected = true
        wxPlayer.bringSubviewToFront(wxPlayer.bottomView)
       
    }
    func startPlayVideo(btn: UIButton) {
        let model = dataArray[btn.tag]
        
        if DataBase.shareDataBase.selectEntity(model.replyid) == nil {
            DataBase.shareDataBase.insertWithModel(model)
        }

        currentIndexPath = NSIndexPath(forRow: btn.tag, inSection: 0)
        self.currentCell = (btn.superview?.superview as? HotCell)!
        currentCell.playBtn.selected = true
        
        if (wxPlayer != nil) {
            releaseWXPlayer()
            wxPlayer = WXPlayer(frame: self.currentCell.imageIcon.bounds)
            wxPlayer.delegate = self
            wxPlayer.URLString = model.mp4_url
            wxPlayer.titleLabel.text = model.title
  
        } else {
            wxPlayer = WXPlayer(frame: self.currentCell.imageIcon.bounds)
            wxPlayer.delegate = self
            wxPlayer.URLString = model.mp4_url
            wxPlayer.titleLabel.text = model.title
        }
        self.currentCell.imageIcon.addSubview(wxPlayer)
        self.currentCell.imageIcon.bringSubviewToFront(wxPlayer)
        self.currentCell.playBtn.superview?.sendSubviewToBack(self.currentCell.playBtn)
        self.hotTableView.reloadData()
        
    }
    
    
    
    func releaseWXPlayer() {
        if wxPlayer != nil {
            wxPlayer.player.currentItem?.cancelPendingSeeks()
            wxPlayer.player.currentItem?.asset.cancelLoading()
            wxPlayer.pause()
            
            wxPlayer.removeFromSuperview()
            wxPlayer.playerLayer.removeFromSuperlayer()
            wxPlayer.player.replaceCurrentItemWithPlayerItem(nil)
            
            wxPlayer.player = nil
            wxPlayer.currentItem = nil
            //释放定时器，否侧不会调用WMPlayer中的dealloc方法
            if wxPlayer.autoDismissTimer != nil {
                wxPlayer.autoDismissTimer.invalidate()
                wxPlayer.autoDismissTimer = nil
            }
            wxPlayer.playOrPauseBtn = nil
            wxPlayer.playerLayer = nil
            wxPlayer = nil
        }
       
        
    }

    

}
//MARK： UITableView、WMPlayerDelegate代理

extension HotBaseViewController: UITableViewDelegate, UITableViewDataSource,WXPlayerDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == hotTableView {
            return dataArray.count
        } else if tableView == shareTableView {
            return 3
        }
        return 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if tableView == hotTableView {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("hotCellId", forIndexPath: indexPath) as! HotCell
            
            let  model = dataArray[indexPath.row]
           
            cell.imageIcon.kf_setImageWithURL(NSURL(string: model.cover), placeholderImage: UIImage(named: "default_poster_480_270"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
            cell.playtimesLabel.text = "\(model.playCount)人看过"
            cell.titleLabel.text = model.title
            cell.selectionStyle = .None
            cell.agreeBt.selected = model.agreeFlag
            cell.agreeClousure = {
                [weak model]
                (btn) in
                model!.agreeFlag = !(model!.agreeFlag)
                btn.selected = (model!.agreeFlag)
            }
            cell.shareClousure = { [unowned self] in
               
                self.configShareView()
                
            }
            cell.commentClosure = { [unowned self] (str) in
                let vc = CommentViewController()
                vc.titleString = str
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
            cell.playBtn.addTarget(self, action: #selector(startPlayVideo), forControlEvents: .TouchUpInside)
            cell.playBtn.tag = indexPath.row
            if currentIndexPath != nil  {
                if (indexPath.row==currentIndexPath.row) && wxPlayer != nil {
                    cell.playBtn.superview?.sendSubviewToBack(cell.playBtn)
                    
                }else{
                    cell.playBtn.superview?.bringSubviewToFront(cell.playBtn)
                    
                }
            }
            
            
            
            return cell
            
        } else if tableView == shareTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("alertCellId", forIndexPath: indexPath) as! AlertCell
            if indexPath.row == 0 {
                cell.imageIcon.image = UIImage(named: "icon_weixin")
                cell.nameLabel.text = "微信"
                return cell
            } else if indexPath.row == 1 {
                cell.imageIcon.image = UIImage(named: "icon_qq")
                cell.nameLabel.text = "QQ"
                return cell
            } else {
                cell.imageIcon.image = UIImage(named: "icon_sina")
                cell.nameLabel.text = "新浪"
                return  cell
            }
            
            
        }
        
        
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == hotTableView {
            return 250
        } else if tableView == shareTableView {
            return 80
        } else {
            return 0
        }
        
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == hotTableView {
            

        } else if tableView == shareTableView {
            if indexPath.row == 0 {
                print("已分享到微信！")
                hideShareView()
                let url = NSURL(string: "wechat://")
                UIApplication.sharedApplication().openURL(url!)
                
            } else if indexPath.row == 1 {
                print("已分享到QQ！")
                hideShareView()
                let url = NSURL(string: "testKitchen://")
                UIApplication.sharedApplication().openURL(url!)
                
            } else if indexPath.row == 2 {
                print("已分享到新浪！")
                hideShareView()
            }
            
        }
        
 
    }
  
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(scrollView == self.hotTableView){
                if (wxPlayer == nil) {
                    return
                }
                
                if ((wxPlayer.superview) != nil) {
                    let rectInTableView = self.hotTableView.rectForRowAtIndexPath(currentIndexPath)
                    let rectInSuperview = self.hotTableView.convertRect(rectInTableView, toView: self.hotTableView.superview)
                    
                    
                    if (rectInSuperview.origin.y < -self.currentCell.imageIcon.frame.size.height || rectInSuperview.origin.y > screenHeight-104) {//往上拖动
                        self.releaseWXPlayer()

                        self.hotTableView.reloadData()
                        
                    }
                }
                
            }

      
    }
    

    func wxplayer(wxplayer: WXPlayer!, clickedCloseButton closeBtn: UIButton!) {
        statusBarHidenClosure(false)
        
        currentCell = (self.hotTableView.cellForRowAtIndexPath(NSIndexPath(forRow: currentIndexPath.row, inSection: 0)) as? HotCell)!
        currentCell.playBtn.superview?.bringSubviewToFront(currentCell.playBtn)
        self.releaseWXPlayer()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func wxplayer(wxplayer: WXPlayer!, clickedFullScreenButton fullScreenBtn: UIButton!) {
        
        if fullScreenBtn.selected {
            wxPlayer.isFullscreen = true
            self.setNeedsStatusBarAppearanceUpdate()
            self.toFullScreenWithInterfaceOrientation(.LandscapeLeft)
        } else {
            self.toCell()
        }
    }
    
    func wxplayerFinishedPlay(wxplayer: WXPlayer!) {
        currentCell = self.hotTableView.cellForRowAtIndexPath(NSIndexPath(forRow: currentIndexPath.row, inSection: 0)) as! HotCell
        currentCell.playBtn.superview?.bringSubviewToFront(currentCell.playBtn)
        self.releaseWXPlayer()
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

//MARK: WXCollectionViewProtocol协议
protocol WXTableViewProtocol: NSObjectProtocol {
    
    func addRefresh(tableView: UITableView, header: (() -> ())?, footer: (() -> ())?)
}


extension WXTableViewProtocol where Self: UIViewController {
    func addRefresh(tableView: UITableView, header: (() -> ())?, footer: (() -> ())?) {
        
        if header != nil {
            tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: header)
        }
        
        if footer != nil {
            tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: footer)
        }
    }
    
}



