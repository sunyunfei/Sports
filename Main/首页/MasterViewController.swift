//
//  MasterViewController.swift
//  sports
//
//  Created by --- on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

let matser_cell:String = "MasterCell"
class MasterViewController: RootTableViewController {

    var datas:Array<MasterModel> = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "大师列表"
        self.view.backgroundColor = UIColor.white
        self.tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.tableView.register(UINib.init(nibName: matser_cell, bundle: nil), forCellReuseIdentifier: matser_cell)
        self.tableView.tableFooterView = UIView.init()
        //获取数据
        refreshData()
    }
    
//数据刷新
   override func refreshData(){
        
        self.view.makeToastActivity(.center)
        BmobTools.post_master(success: { (array) in
            self.view.hideToastActivity()
            self.datas = array
            self.tableView.reloadData()
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    //表的代理事件
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MasterCell = tableView.dequeueReusableCell(withIdentifier: matser_cell, for: indexPath) as! MasterCell
        cell.model = self.datas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //masterDetail
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detail:MasterDetailViewController = story.instantiateViewController(withIdentifier: "masterDetail") as! MasterDetailViewController
        detail.title = "大师详情"
        detail.masterModel = self.datas[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }

}
