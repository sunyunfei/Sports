//
//  MineViewController.swift
//  sports
//
//  Created by --- on 2018/12/11.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class MineViewController: RootTableViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 40
        
        //显示数据
        let user:UserModel? = SportsTools.obtainUser()
        if let u:UserModel = user {
            
            if let s = u.icon{
                
                //icon.kf.setImage(with: URL.init(string: (u.icon)!))
                icon.sd_setImage(with: URL.init(string: (u.icon)!), completed: nil)
            }
            nameLabel.text = "名称:" + (u.name)!
            ageLabel.text = "年龄:" + (u.age)!
            introLabel.text = u.intro
            
        }
    }
    

}
