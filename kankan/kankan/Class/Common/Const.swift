//
//  Theme.swift
//  kankan
//
//  Created by Xin on 16/10/19.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import Foundation
import UIKit


let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height



//HomeUrl

let homeAllTVUrl = "http://list.pad.kankan.com/common_mobile_list/act,1/type,teleplay/sort,wvv/status,zp/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,30/"

let homeAllMovieUrl = "http://list.pad.kankan.com/common_mobile_list/act,1/type,movie/status,zp/sort,wvv/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,30/"

let homeAllVMovieUrl = "http://list.pad.kankan.com/common_mobile_list/act,1/type,vmovie/sort,wvv/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,30/"

let homeAllVarietyUrl = "http://list.pad.kankan.com/common_mobile_list/act,1/type,tv/sort,wvv/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,30/"

let homeAllAnimUrl = "http://list.pad.kankan.com/common_mobile_list/act,1/type,anime/status,zp/sort,wvv/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,30/"

let homeAllChildUrl = "http://list.pad.kankan.com/common_mobile_list/act,1/type,anime/genre,qzdm/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,30/"

let homeAllDocuUrl = "http://list.pad.kankan.com/common_mobile_list/act,1/type,documentary/sort,wvv/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,30/"


let homeRecUrl = "http://pad.kankan.com/android/index_3_2.json"

let homeTVUrl = "http://pad.kankan.com/channel/channel_teleplay.json"

let homeMovieUrl = "http://pad.kankan.com/channel/channel_movie.json"

let homeVMovieUrl = "http://pad.kankan.com/channel/channel_vmovie.json"

let homeVarietyUrl = "http://pad.kankan.com/channel/channel_tv.json"

let homeAnimationUrl = "http://pad.kankan.com/channel/channel_anime.json"

let homeChildrenUrl = "http://pad.kankan.com/channel/channel_children.json"

let homeDocuUrl = "http://pad.kankan.com/channel/channel_documentary.json"

let homeWarUrl = "http://list.pad.kankan.com/common_mobile_list_mixed/channel,war/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,12/"

let homeLoveUrl = "http://list.pad.kankan.com/common_mobile_list_mixed/channel,love/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,12/"

let homeGuZhuangUrl = "http://list.pad.kankan.com/common_mobile_list_mixed/channel,guzhuang/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,12/"

let homeWuYeUrl = "http://list.pad.kankan.com/common_mobile_list_mixed/channel,wuye/os,az/osver,6.0/productver,5.3.0.65/page,%ld/pernum,12/"

let homeSingleJson = "http://api.pad.kankan.com/playLink.php?type=movie&movieid="

//HotUrl
let HotSelectedUrl = "http://pad.kankan.com/android/hot_video_tab1.json"

let HotBeautyUrl = "http://pad.kankan.com/android/hot_video_tab3.json"

let HotSocialUrl = "http://pad.kankan.com/android/hot_video_tab4.json"

let HotJokeUrl = "http://pad.kankan.com/android/hot_video_tab2.json"





//VIPUrl
let VIPRecUrl = "http://busi.vip.kankan.com/mobile/getHome?respType=json"

let VIPAllUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=0&order=0&pageNo=%ld&pagesize=12"

let VIPActUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=1&order=0&pageNo=%ld&pagesize=12"

let VIPFunnyUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=2&order=0&pageNo=%ld&pagesize=12"

let VIPLoveUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=3&order=0&pageNo=%ld&pagesize=12"

let VIPScienceUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=4&order=0&pageNo=%ld&pagesize=12"

let VIPDisasterUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=5&order=0&pageNo=%ld&pagesize=12"

let VIPTerrifyUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=6&order=0&pageNo=%ld&pagesize=12"

let VIPSuspenseUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=7&order=0&pageNo=%ld&pagesize=12"

let VIPMagicUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=8&order=0&pageNo=%ld&pagesize=12"

let VIPWarUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=9&order=0&pageNo=%ld&pagesize=12"

let VIPSinUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=10&order=0&pageNo=%ld&pagesize=12"

let VIPPanicUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=11&order=0&pageNo=%ld&pagesize=12"

let VIPAnimUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=12&order=0&pageNo=%ld&pagesize=12"

let VIPRelationUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=13&order=0&pageNo=%ld&pagesize=12"

let VIPDocuUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=14&order=0&pageNo=%ld&pagesize=12"

let VIPStoryUrl = "http://busi.vip.kankan.com/mobile/getMovieInfoList?respType=json&s=250x350&category=15&order=0&pageNo=%ld&pagesize=12"








