//
//  XLAskViewController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/18.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class XLAskViewController: UITableViewController {

    var xlId:String?
    var datas:Array<XLASKModel> = Array()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "提问"
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.tableView.tableFooterView = UIView.init()
        load()
    }
    
    
    func load(){
        
        self.view.makeToastActivity(.center)
        BmobTools.post_tw(xlId!,success: { (array) in
            
            self.view.hideToastActivity()
            self.datas = array
            
            self.tableView.reloadData()
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.textColor = UIColor.lightGray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.selectionStyle = .none
        let model:XLASKModel = datas[indexPath.row]
        if let replay = model.replay{
            
            cell.textLabel?.text = (model.userName)! + " 提问: " + (model.ask)! + "\n\n" + "回复： " + replay
        }
        
        
        return cell;
    }

    
}
