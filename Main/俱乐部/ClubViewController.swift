//
//  ClubViewController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/21.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit
let club_cell:String = "ClubCell"
class ClubViewController: RootTableViewController {
    var tableDatas:Array<ClubModel> = Array()//表数据
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "俱乐部"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        //self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1))
        self.tableView.register(UINib.init(nibName: club_cell, bundle: nil), forCellReuseIdentifier: club_cell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData(){
        
        self.view.makeToastActivity(.center)
        
        BmobTools.post_club(success: { (array) in
            
            self.view.hideToastActivity()
            
            self.tableDatas = array
            
            self.tableView.reloadData()
            
            
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    //表的代理事件
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ClubCell = tableView.dequeueReusableCell(withIdentifier: club_cell, for: indexPath) as! ClubCell
        cell.model = self.tableDatas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detail:ClubDetailViewController = story.instantiateViewController(withIdentifier: "club_detail") as! ClubDetailViewController
        detail.model = self.tableDatas[indexPath.row]
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
