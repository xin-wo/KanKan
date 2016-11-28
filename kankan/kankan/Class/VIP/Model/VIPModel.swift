//
//  VIPModel.swift
//  kankan
//
//  Created by Xin on 16/10/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class VIPModel: NSObject {
    var image: String!
    var movieDesc: String!
    var movieId: NSNumber!
    var movieName: String!
    var movieScore: String!
    var movieStatus: NSNumber!
    var productId: NSNumber!
    var productType: NSNumber!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}

class VIPHomeScrModel: NSObject {
    var image: String!
    var movieId: NSNumber!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}


class VIPHomeHotAndNewModel: NSObject {
    var image: String!
    var movieId: NSNumber!
    var score: String!
    var subTitle: String!
    var title: String!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

class VIPHomeModulesModel: NSObject  {
    var moduleName: String!
    var movies: [VIPHomeHotAndNewModel]!
    var indexRec: NSNumber!
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "movies" {
            var dataArray: [VIPHomeHotAndNewModel] = []
            let array = value as! [AnyObject]
            
            for dic in array {
                let model = VIPHomeHotAndNewModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                dataArray.append(model)
                
            }
            movies = dataArray
           
        } else {
            super.setValue(value, forKey: key)
        }
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}


