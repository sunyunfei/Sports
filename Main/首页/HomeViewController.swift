//
//  HomeViewController.swift
//  sports
//
//  Created by 李帅 on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit
let home_cell = "HomeCell"
class HomeViewController: RootViewController,UITableViewDelegate,UITableViewDataSource,ZCycleViewProtocol {
    func cycleViewDidScrollToIndex(_ index: Int) {
       
        
    }
    
    func cycleViewDidSelectedIndex(_ index: Int) {
       
        self.skipDetail(index)
    }
    

    @IBOutlet weak var headView: UIView!//头部视图
    
    @IBOutlet weak var tableView: UITableView!//表
    
    //轮播图
    var cycleView:ZCycleView?
    
    var tableDatas:Array<HomeModel> = Array()//表数据
    
    var scrollDatas:Array<HomeModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: home_cell, bundle: nil), forCellReuseIdentifier: home_cell)
        tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1))
        
        cycleView = ZCycleView(frame: self.headView.bounds)
        cycleView?.delegate = self
        self.headView.addSubview(cycleView!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //登录
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        if let a = account{
            
            if a.count > 0{
                
                //已经登陆了，无需再次登录
                loadData()
                return;
            }else{
                
                 SportsTools.presentLoginVC()
            }
        }else{
            SportsTools.presentLoginVC()
        }
       
    }
    
    //活动搜索
    @IBAction func clickSearchBtn(_ sender: Any) {
        
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let search:HomeSearchViewController = story.instantiateViewController(withIdentifier: "search") as! HomeSearchViewController
        search.hidesBottomBarWhenPushed = true
        search.datas = tableDatas
        self.navigationController?.pushViewController(search, animated: true)
    }
    
    
    //大师按钮
    @IBAction func clickMasterBtn(_ sender: Any) {
        
        let master:MasterViewController = MasterViewController()
        master.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(master, animated: true)
    }
    
    //比赛按钮
    @IBAction func clickgameBtn(_ sender: Any) {
        
        let game:GameController = GameController()
        game.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(game, animated: true)
    }
    
    //数据的请求
    func loadData(){
        
        if self.tableDatas.count > 0 {
            
            self.tableDatas.removeAll()
        }
        
        
        self.view.makeToastActivity(.center)
        BmobTools.post_home(success: { (array) in
            
            self.view.hideToastActivity()
            self.tableDatas = array
            
            //轮播图加载
            var imgArrays:Array<String> = Array()
            for model:HomeModel in self.tableDatas{
                
                if model.type == true{
                    self.scrollDatas.append(model)
                    imgArrays.append(model.imageName!)
                }
            }
            
            self.cycleView?.setUrlsGroup(imgArrays)
            
            //表的刷新
            self.tableView.reloadData()
            
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    func skipDetail(_ index:Int){
        
        let model:HomeModel = self.scrollDatas[index]
        
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detail:ActiveDetailViewController = story.instantiateViewController(withIdentifier: "active_detail") as! ActiveDetailViewController
        detail.homeModel = model
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    //表的代理事件
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:HomeCell = tableView.dequeueReusableCell(withIdentifier: home_cell, for: indexPath) as! HomeCell
        cell.model = self.tableDatas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detail:ActiveDetailViewController = story.instantiateViewController(withIdentifier: "active_detail") as! ActiveDetailViewController
        detail.homeModel = self.tableDatas[indexPath.row]
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
