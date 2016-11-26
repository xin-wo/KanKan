//
//  AlertCell.swift
//  响巢看看
//
//  Created by qianfeng on 16/11/7.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class AlertCell: UITableViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
