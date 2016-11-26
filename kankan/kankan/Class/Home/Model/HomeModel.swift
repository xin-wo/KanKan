//
//  HomeModel.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/20.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class HomeScrModel: NSObject {
    var subtitle: String!
    var movieid: String!
    var poster: String!
    var title: String!
    var ad_url: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}


class HomeBsModel: NSObject {
    var block_id: String!
    var data: [HomeBsDataModel]!
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "data" {
            var dataArray = [HomeBsDataModel]()
            
            let array = value as! [AnyObject]
            for dic in array {
                
                let model = HomeBsDataModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                dataArray.append(model)
            }
            
            
            data = dataArray

        } else {
            super.setValue(value, forKey: key)
        }
        
       
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}

class HomeBsDataModel: NSObject {
    var kankan_type: String!
    var movieid: String!
    var poster: String!
    var title: String!
    var rating: String!
    var subtitle: String!
    var is_vip: String!
    var is_top: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}

class hotwordModel: NSObject {
    var words: String!
    var action_target: [hotwordTargetModel]!
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "action_target" {
            var dataArray = [hotwordTargetModel]()
            let model = hotwordTargetModel()
                model.setValuesForKeysWithDictionary(value as! [String : AnyObject])
                dataArray.append(model)
            
            action_target = dataArray
            
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
class hotwordTargetModel: NSObject {
    var url: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}


class HomeBkCgModel: NSObject {
    var block_id: String!
    var block_title: String!
    var hot_words: [hotwordModel]?
    var is_heng_tu: String!
    var more_link: String!
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "hot_words" {
            var dataArray = [hotwordModel]()
            
            let array = (value as! NSArray) as [AnyObject]
            for dic in array {
                let model = hotwordModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                dataArray.append(model)
                
            }
            hot_words = dataArray
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
   
}


class HomeAllModel: NSObject {
    var attract: String!
    var id: NSNumber!
    var isTrailer: String!
    var label: String!
    var poster: String!
    var score: NSNumber!
    var title: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}

class HomeSingleModel: NSObject {
    var id: String!
    var screen_shot: String!
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}


class HomeJumpModel: NSObject {
    var attract: String!
    var id: NSNumber!
    var label: String!
    var poster: String!
    var score: String!
    var title: String!
    var type: NSNumber!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}







