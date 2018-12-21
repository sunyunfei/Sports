//
//  XLSearchController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/18.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class XLSearchController: UITableViewController,UISearchBarDelegate {

   
    
    @IBOutlet weak var searchBar: UISearchBar!
    
     var datas:Array<XLModel>?//数据
    var showDatas:Array<XLModel> = Array()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "训练搜索"
        tableView.register(UINib.init(nibName: xl_cell, bundle: nil), forCellReuseIdentifier: xl_cell)
        searchBar.delegate = self
    }

    
    //搜索点击
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        
        let str:String? = searchBar.text
        
        
        if showDatas.count > 0{
            
            showDatas.removeAll()
        }
        
        if (datas?.count)! < 0 {
            
            return
        }
        
        if let s = str{
            
            //开始匹配
            for obj:XLModel in (datas)!{
                
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
        
        let cell:XLCell = tableView.dequeueReusableCell(withIdentifier: xl_cell, for: indexPath) as! XLCell
        cell.model = self.showDatas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detail:XLDetailController = story.instantiateViewController(withIdentifier: "xl_detail") as! XLDetailController
        detail.model = self.showDatas[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }

    

}
