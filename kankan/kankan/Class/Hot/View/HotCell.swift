//
//  HotCell.swift
//  响巢看看
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit


class HotCell: UITableViewCell {

    
    @IBOutlet weak var agreeBt: UIButton!

    var agreeClousure: ((UIButton) -> ())?
    var shareClousure: ((Void) -> (Void))?
    var commentClosure: ((String) -> (Void))?
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    
    @IBOutlet weak var playtimesLabel: UILabel!
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == 101 {
            let btn = viewWithTag(101) as! UIButton
            
            agreeClousure!(btn)
        } else if sender.tag == 102 {
            shareClousure!()
            
        } else {
            commentClosure!(titleLabel.text!)
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
//        playBtn.userInteractionEnabled = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
