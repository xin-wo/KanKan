//
//  VideoEntity+CoreDataProperties.swift
//  kankan
//
//  Created by Xin on 16/11/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension VideoEntity {

    @NSManaged var cover: String?
    @NSManaged var title: String?
    @NSManaged var replyid: String?
    @NSManaged var playCount: NSNumber?
    @NSManaged var mp4_url: String?
}
