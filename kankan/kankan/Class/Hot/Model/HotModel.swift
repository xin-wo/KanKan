//
//  HotModel.swift
//  kankan
//
//  Created by Xin on 16/11/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HotModel: NSObject {

    var img: String!
    var title: String!
    var videoid: NSNumber!
    var playtimes: NSNumber!
    var agreeFlag: Bool = false
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}

class PlayerModel: NSObject {
    var cover: String!
    var length: NSNumber!
    var m3u8_url: String!
    var m3u8Hd_url: String!
    var mp4_url: String!
    var mp4Hd_url: String!
    var playCount: NSNumber!
    var playersize: NSNumber!
    var ptime: String!
    var replyBoard: String!
    var replyid: String!
    var sectiontitle: String!
    var title: String!
    var topicDesc: String!
    var topicImg: String!
    var topicName: String!
    var topicSid: String!
    var vid: String!
    var videosource: String!
    var videoTopic: PlayerTopic!
    
    var agreeFlag: Bool = false
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "videoTopic" {
            let model = PlayerTopic()
            model.setValuesForKeysWithDictionary(value as! [String:AnyObject])
            videoTopic = model
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}

class PlayerTopic: NSObject {
    var alias: String!
    var tname: String!
    var tid: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
