//
//  VIPScienceViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/31.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class VIPScienceViewController: VIPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        url = VIPScienceUrl
        loadData()
        configUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}