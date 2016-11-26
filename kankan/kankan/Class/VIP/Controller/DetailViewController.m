//
//  DetailViewController.m
//  WMVideoPlayer
//
//  Created by 郑文明 on 16/2/1.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "DetailViewController.h"
#import "WXPlayer.h"


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface DetailViewController ()<WXPlayerDelegate>{
    WXPlayer  *wxPlayer;
    CGRect     playerFrame;
}

@end

@implementation DetailViewController

//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}

- (void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation
{

    [[UIApplication sharedApplication] setStatusBarHidden:true];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [wxPlayer removeFromSuperview];
    wxPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wxPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wxPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    } 
    
    wxPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    wxPlayer.playerLayer.frame =  CGRectMake(0, 0, kScreenHeight,kScreenWidth);
    
    [wxPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kScreenWidth-40);
        make.width.mas_equalTo(kScreenHeight);
        make.left.mas_equalTo(wxPlayer);
    }];
    [wxPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(wxPlayer).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    [wxPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxPlayer.topView).with.offset(5);
        make.height.mas_equalTo(30);
        make.top.equalTo(wxPlayer.topView).with.offset(5);
        make.width.mas_equalTo(30);
    }];
    [wxPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxPlayer.topView).with.offset(45);
        make.right.equalTo(wxPlayer.topView).with.offset(-45);
        make.center.equalTo(wxPlayer.topView);
        make.top.equalTo(wxPlayer.topView).with.offset(0);
        
    }];
    [wxPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    [wxPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-37, -(kScreenWidth/2-37)));
    }];
    
    [wxPlayer.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxPlayer.bottomView).with.offset(45);
        make.right.equalTo(wxPlayer.bottomView).with.offset(-45);
        make.center.equalTo(wxPlayer.bottomView);
    }];
    [wxPlayer.loadingProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxPlayer.progressSlider);
        make.right.equalTo(wxPlayer.progressSlider);
        make.center.equalTo(wxPlayer.progressSlider);
    }];
    [wxPlayer.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wxPlayer.bottomView).with.offset(0);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(wxPlayer.bottomView).with.offset(0);
        make.width.mas_equalTo(40);
        
    }];
    [wxPlayer.rightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxPlayer.bottomView).with.offset(45);
        make.right.equalTo(wxPlayer.bottomView).with.offset(-45);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(wxPlayer.bottomView).with.offset(0);
    }];
    [wxPlayer.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxPlayer.topView).with.offset(45);
        make.right.equalTo(wxPlayer.topView).with.offset(-45);
        make.center.equalTo(wxPlayer.topView);
        make.top.equalTo(wxPlayer.topView).with.offset(0);
        
    }];
    [wxPlayer.loadFailedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wxPlayer);
        make.width.equalTo(wxPlayer);
        make.height.equalTo(@30);
        
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:wxPlayer];
    wxPlayer.fullScreenBtn.selected = YES;
    [wxPlayer bringSubviewToFront:wxPlayer.bottomView];
    
}
-(void)toNormal{
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    [wxPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wxPlayer.transform = CGAffineTransformIdentity;
        wxPlayer.frame =CGRectMake(playerFrame.origin.x, playerFrame.origin.y, playerFrame.size.width, playerFrame.size.height);
        wxPlayer.playerLayer.frame =  wxPlayer.bounds;
        [self.view addSubview:wxPlayer];
        [wxPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wxPlayer).with.offset(0);
            make.right.equalTo(wxPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wxPlayer).with.offset(0);
        }];
       
        
        [wxPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wxPlayer).with.offset(0);
            make.right.equalTo(wxPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wxPlayer).with.offset(0);
        }];
        
        
        [wxPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wxPlayer.topView).with.offset(5);
            make.height.mas_equalTo(30);
            make.top.equalTo(wxPlayer.topView).with.offset(5);
            make.width.mas_equalTo(30);
        }];
        
        
        [wxPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wxPlayer.topView).with.offset(45);
            make.right.equalTo(wxPlayer.topView).with.offset(-45);
            make.center.equalTo(wxPlayer.topView);
            make.top.equalTo(wxPlayer.topView).with.offset(0);
        }];
        
        [wxPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wxPlayer);
            make.width.equalTo(wxPlayer);
            make.height.equalTo(@30);
        }];
        
    }completion:^(BOOL finished) {
        wxPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        wxPlayer.fullScreenBtn.selected = NO;
        
    }];
}

///播放器事件
-(void)wxplayer:(WXPlayer *)wxplayer clickedCloseButton:(UIButton *)closeBtn{
    NSLog(@"clickedCloseButton");
    [self releaseWXPlayer];
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    [self.navigationController popViewControllerAnimated:YES];
    
}
///播放暂停
-(void)wxplayer:(WXPlayer *)wxplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    NSLog(@"clickedPlayOrPauseButton");
    
}
///全屏按钮
-(void)wxplayer:(WXPlayer *)wxplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (fullScreenBtn.isSelected) {//全屏显示
        wxPlayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [self toNormal];
    }
}
///单击播放器
-(void)wxplayer:(WXPlayer *)wxplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}
///双击播放器
-(void)wxplayer:(WXPlayer *)wxplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}
///播放状态
-(void)wxplayerFailedPlay:(WXPlayer *)wxplayer WXPlayerStatus:(WXPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wxplayerReadyToPlay:(WXPlayer *)wxplayer WXPlayerStatus:(WXPlayerState)state{
    NSLog(@"wmplayerDidReadyToPlay");
}
-(void)wxplayerFinishedPlay:(WXPlayer *)wxplayer{
    NSLog(@"wmplayerDidFinishedPlay");
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (wxPlayer==nil||wxPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wxPlayer.isFullscreen) {
                    [self toNormal];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
                wxPlayer.isFullscreen = YES;
                [self setNeedsStatusBarAppearanceUpdate];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
                wxPlayer.isFullscreen = YES;
                [self setNeedsStatusBarAppearanceUpdate];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    self.navigationController.navigationBarHidden = YES;

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
#pragma mark
#pragma mark viewDidLoad
- (void)viewDidLoad
{    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    playerFrame = CGRectMake(0, 20, kScreenWidth, (kScreenWidth)*(0.7));
    wxPlayer = [[WXPlayer alloc]initWithFrame:playerFrame];
    wxPlayer.delegate = self;
    wxPlayer.closeBtnStyle = CloseBtnStylePop;
    wxPlayer.URLString = self.URLString;
    wxPlayer.titleLabel.text = self.title;
    wxPlayer.closeBtn.hidden = NO;
    [self.view addSubview:wxPlayer];

}

- (void)releaseWXPlayer
{
    [wxPlayer.player.currentItem cancelPendingSeeks];
    [wxPlayer.player.currentItem.asset cancelLoading];
    [wxPlayer pause];
    [wxPlayer removeFromSuperview];
    [wxPlayer.playerLayer removeFromSuperlayer];
    [wxPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wxPlayer.player = nil;
    wxPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wxPlayer.autoDismissTimer invalidate];
    wxPlayer.autoDismissTimer = nil;
    
    
    wxPlayer.playOrPauseBtn = nil;
    wxPlayer.playerLayer = nil;
    wxPlayer = nil;
}

- (void)dealloc
{
    [self releaseWXPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"DetailViewController deallco");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
