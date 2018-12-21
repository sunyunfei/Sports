//
//  XLController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/18.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit
let xl_cell = "XLCell"
class XLController: UITableViewController,ZCycleViewProtocol {
    func cycleViewDidScrollToIndex(_ index: Int) {
        
    }
    
    func cycleViewDidSelectedIndex(_ index: Int) {
        
        let model:XLModel = self.tableDatas[index]
        
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detail:XLDetailController = story.instantiateViewController(withIdentifier: "xl_detail") as! XLDetailController
        detail.model = model
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    //轮播图
    var cycleView:ZCycleView?
    
    var tableDatas:Array<XLModel> = Array()//表数据

    @IBOutlet weak var headView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        //self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1))
        self.tableView.register(UINib.init(nibName: xl_cell, bundle: nil), forCellReuseIdentifier: xl_cell)
        cycleView = ZCycleView(frame: self.headView.bounds)
        cycleView?.delegate = self
        self.headView.addSubview(cycleView!)
        
        loadData()
    }
    
    
    func loadData(){
        
        self.view.makeToastActivity(.center)
        
        BmobTools.post_xl(success: { (array) in
            
            self.view.hideToastActivity()
            
            self.tableDatas = array
            
            //轮播图加载
            var imgArrays:Array<String> = Array()
            for model:XLModel in self.tableDatas{
                
                if let i = model.icon{
                    
                    imgArrays.append(i)
                }
            }
            
            self.cycleView?.setUrlsGroup(imgArrays)
            
            self.tableView.reloadData()
            
            
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }

    //搜索
    @IBAction func clickSearch(_ sender: Any) {
        
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let search:XLSearchController = story.instantiateViewController(withIdentifier: "xl_search") as! XLSearchController
        search.hidesBottomBarWhenPushed = true
        search.datas = self.tableDatas
        self.navigationController?.pushViewController(search, animated: true)
    }
    
    //表的代理事件
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XLCell = tableView.dequeueReusableCell(withIdentifier: xl_cell, for: indexPath) as! XLCell
        cell.model = self.tableDatas[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detail:XLDetailController = story.instantiateViewController(withIdentifier: "xl_detail") as! XLDetailController
        detail.model = self.tableDatas[indexPath.row]
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
