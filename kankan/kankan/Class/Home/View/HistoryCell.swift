//
//  HistoryCell.swift
//  响巢看看
//
//  Created by qianfeng on 16/11/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit




class HistoryCell: UICollectionViewCell {
    
    var deleteClosure: (Void -> Void)!
    
    
    
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    func angelToRandian(x: Double) -> Double  {
        return (x)/180.0*M_PI
    }
    
    @IBOutlet weak var bgView: UIView!
    
    @IBAction func deleteBtnAction(sender: UIButton) {
        deleteClosure()
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(startEdit), name: "startEdit", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(endEdit), name: "endEdit", object: nil)
        
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
    }
    
    func startEdit() {
       
        print("startEdit")
        
        deleteBtn.hidden = false
        let transform = CATransform3DScale(self.layer.transform, 0.9, 0.9, 0.9)
        bgView.layer.transform = transform
        
    }
    
    func endEdit() {
        print("endEdit")
        deleteBtn.hidden = true

        let transform = CATransform3DScale(self.layer.transform, 1.0, 1.0, 1.0)
        bgView.layer.transform = transform
        
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
   
    
    
    
}
