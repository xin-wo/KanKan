//
//  VideoEntity+CoreDataProperties.swift
//  响巢看看
//
//  Created by qianfeng on 16/11/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension VideoEntity {

    @NSManaged var img: String?
    @NSManaged var title: String?
    @NSManaged var videoid: NSNumber?
    @NSManaged var playtimes: NSNumber?

}
