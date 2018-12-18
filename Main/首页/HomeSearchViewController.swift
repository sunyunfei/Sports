//
//  HomeSearchViewController.swift
//  sports
//
//  Created by --- on 2018/12/17.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class HomeSearchViewController: RootTableViewController,UISearchBarDelegate {

    var datas:Array<HomeModel>?
    var showDatas:Array<HomeModel> = Array()
    @IBOutlet weak var search: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "活动搜索"
        tableView.register(UINib.init(nibName: home_cell, bundle: nil), forCellReuseIdentifier: home_cell)
        search.delegate = self
    }

    //搜索点击
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        
        let str:String? = search.text
        
        
        if showDatas.count > 0{
            
            showDatas.removeAll()
        }
        
        if (datas?.count)! < 0 {
            
            return
        }
        
        if let s = str{
            
            //开始匹配
            for obj:HomeModel in (datas)!{
                
                let flag:Bool = (obj.name?.contains(s))!
                if flag{
                    
                    showDatas.append(obj)
                }
            }
        }
        
        self.view.endEditing(true)
        self.tableView.reloadData()
    }
    
    
    //表的代理事件
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.showDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:HomeCell = tableView.dequeueReusableCell(withIdentifier: home_cell, for: indexPath) as! HomeCell
        cell.model = self.showDatas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detail:ActiveDetailViewController = story.instantiateViewController(withIdentifier: "active_detail") as! ActiveDetailViewController
        detail.homeModel = self.showDatas[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
