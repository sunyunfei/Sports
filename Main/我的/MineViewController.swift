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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
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
    
    @IBAction func clickEdit(_ sender: Any) {
        
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let login:SetController = story.instantiateViewController(withIdentifier: "set") as! SetController
        login.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(login, animated: true)
    }
    
    
    //退出登录
    @IBAction func loginOut(_ sender: Any) {
        
        let d:UserDefaults = UserDefaults.init()
        d.removeObject(forKey: "location_user")
        d.synchronize()
        
        SportsTools.presentLoginVC()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let s:MineSecondController = MineSecondController()
            s.index = indexPath.row
            s.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(s, animated: true)
        }else if indexPath.section == 1{
            
            //清除缓存
            let size = SDImageCache.shared().getSize()
            SDImageCache.shared().clearDisk(onCompletion: nil)
            self.icon.makeToast("清除缓存" + String(size/1000/1000) + "M成功")
        }
    }
}
