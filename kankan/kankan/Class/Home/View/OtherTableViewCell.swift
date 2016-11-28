//
//  OtherTableViewCell.swift
//  kankan
//
//  Created by Xin on 16/10/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class OtherTableViewCell: UITableViewCell {

    @IBOutlet weak var smallImage: UIImageView!
    
    @IBOutlet weak var itemLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
