//
//  ActiveDetailViewController.swift
//  sports
//
//  Created by --- on 2018/12/11.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class ActiveDetailViewController: RootViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var attentionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var icon: UIImageView!
    
    var homeModel:HomeModel?
    
    var homeDetail:HomeDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "活动详情"
        
        self.nameLabel.text = homeModel?.name
        self.introLabel.text = homeModel?.intro
        if let iconS = homeModel?.imageName {
            
            //icon.kf.setImage(with: URL.init(string: iconS))
            icon.sd_setImage(with: URL.init(string: iconS), completed: nil)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
     
        loadData()
    }
    
    //请求数据
    func loadData(){
        
        BmobTools.post_activeDetail((homeModel?.homeId)!, success: { (detail) in
            self.view.hideToastActivity()
            
            self.homeDetail = detail
            self.attentionLabel.text = "已有" + (self.homeDetail?.attention)! + "人收藏"
            self.tableView.reloadData()
            
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    @IBAction func clickBMBtn(_ sender: Any) {
        
        self.view.makeToastActivity(.center)
        BmobTools.post_bmActive(homeModel!, success: {
            self.view.hideToastActivity()
            self.view.makeToast("报名成功")
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let model = homeDetail {
            
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = homeDetail?.detail
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor.lightGray
        return cell
    }

}
