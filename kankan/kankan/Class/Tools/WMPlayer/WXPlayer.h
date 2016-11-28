//
//  WXPlayer.h
//  kankan
//
//  Created by Xin on 16/11/20.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <Masonry/Masonry.h>
@import MediaPlayer;
@import AVFoundation;
@import UIKit;
// 播放器的几种状态
typedef NS_ENUM(NSInteger, WXPlayerState) {
    WXPlayerStateFailed,        // 播放失败
    WXPlayerStateBuffering,     // 缓冲中
    WXPlayerStatusReadyToPlay,  //将要播放
    WXPlayerStatePlaying,       // 播放中
    WXPlayerStateStopped,        //暂停播放
    WXPlayerStateFinished       //播放完毕
};
// 枚举值，包含播放器左上角的关闭按钮的类型
typedef NS_ENUM(NSInteger, CloseBtnStyle){
    CloseBtnStyleClose,//关闭（X）
    CloseBtnStylePop //pop箭头<-
    
};


@class WXPlayer;
@protocol WXPlayerDelegate <NSObject>
@optional
///播放器事件
//点击播放暂停按钮代理方法
-(void)wxplayer:(WXPlayer *)wxplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn;
//点击关闭按钮代理方法
-(void)wxplayer:(WXPlayer *)wxplayer clickedCloseButton:(UIButton *)closeBtn;
//点击全屏按钮代理方法
-(void)wxplayer:(WXPlayer *)wxplayer clickedFullScreenButton:(UIButton *)fullScreenBtn;
//单击WMPlayer的代理方法
-(void)wxplayer:(WXPlayer *)wxplayer singleTaped:(UITapGestureRecognizer *)singleTap;
//双击WMPlayer的代理方法
-(void)wxplayer:(WXPlayer *)wxplayer doubleTaped:(UITapGestureRecognizer *)doubleTap;

///播放状态
//播放失败的代理方法
-(void)wxplayerFailedPlay:(WXPlayer *)wxplayer WXPlayerStatus:(WXPlayerState)state;
//准备播放的代理方法
-(void)wxplayerReadyToPlay:(WXPlayer *)wxplayer WXPlayerStatus:(WXPlayerState)state;
//播放完毕的代理方法
-(void)wxplayerFinishedPlay:(WXPlayer *)wxplayer;


@end


@interface WXPlayer : UIView

//
//@property (nonatomic, strong) void (^toSwiftFullBlock)(UIButton *sender);
//
//
//@property (nonatomic, strong) void (^toSwiftCloseBlock)(UIButton *sender);
//
//
//@property (nonatomic, strong) void (^toSwiftReadyToPlayBlock)(UIButton *sender);


/**
 * 亮度的进度条
 */
@property (nonatomic,strong) UISlider       *lightSlider;
@property (nonatomic,strong) UISlider       *progressSlider;
@property (nonatomic,strong) UISlider       *volumeSlider;


@property (nonatomic,strong) UIProgressView *loadingProgress;

/**
 *  显示播放时间的UILabel
 */
@property (nonatomic,strong) UILabel        *leftTimeLabel;
@property (nonatomic,strong) UILabel        *rightTimeLabel;

/**
 *  播放器player
 */
@property (nonatomic,retain ) AVPlayer       *player;
/**
 *playerLayer,可以修改frame
 */
@property (nonatomic,retain ) AVPlayerLayer  *playerLayer;

/** 播放器的代理 */
@property (nonatomic, weak)id <WXPlayerDelegate> delegate;
/**
 *  底部操作工具栏
 */
@property (nonatomic,retain ) UIView         *bottomView;
/**
 *  顶部操作工具栏
 */
@property (nonatomic,retain ) UIView         *topView;

/**
 *  显示播放视频的title
 */
@property (nonatomic,strong) UILabel        *titleLabel;
/**
 ＊  播放器状态
 */
@property (nonatomic, assign) WXPlayerState   state;
/**
 ＊  播放器左上角按钮的类型
 */
@property (nonatomic, assign) CloseBtnStyle   closeBtnStyle;
/**
 *  定时器
 */
@property (nonatomic, retain) NSTimer        *autoDismissTimer;
/**
 *  BOOL值判断当前的状态
 */
@property (nonatomic,assign ) BOOL            isFullscreen;
/**
 *  控制全屏的按钮
 */
@property (nonatomic,retain ) UIButton       *fullScreenBtn;
/**
 *  播放暂停按钮
 */
@property (nonatomic,retain ) UIButton       *playOrPauseBtn;
/**
 *  左上角关闭按钮
 */
@property (nonatomic,retain ) UIButton       *closeBtn;
/**
 *  显示加载失败的UILabel
 */
@property (nonatomic,strong) UILabel        *loadFailedLabel;
/**
 *  当前播放的item
 */
@property (nonatomic, retain) AVPlayerItem   *currentItem;
/**
 *  菊花（加载框）
 */
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;
/**
 *  BOOL值判断当前的播放状态
 */
//@property (nonatomic,assign ) BOOL            isPlaying;
/**
 *  设置播放视频的USRLString，可以是本地的路径也可以是http的网络路径
 */
@property (nonatomic,copy) NSString       *URLString;
/**
 *  跳到time处播放
 *  @param seekTime这个时刻，这个时间点
 */

@property (nonatomic, assign) double  seekTime;
/**
 *  播放
 */
- (void)play;

/**
 * 暂停
 */
- (void)pause;


/**
 *  获取正在播放的时间点
 *
 *  @return double的一个时间点
 */
- (double)currentTime;

/**
 * 重置播放器
 */
- (void )resetWXPlayer;
/**
 * 版本号
 */
- (NSString *)version;
@end

