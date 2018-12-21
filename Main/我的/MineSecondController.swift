//
//  MineSecondController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/21.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class MineSecondController: UITableViewController {

    var index:Int?
    var datas:Array<HomeModel> = Array()
    var stDatas:Array<STModel> = Array()
    var kcDatas:Array<ClubCourseModel> = Array()
    
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //晒图
        tableView.register(UINib.init(nibName: st_cell, bundle: nil), forCellReuseIdentifier: st_cell)
        //活动
        tableView.register(UINib.init(nibName: home_cell, bundle: nil), forCellReuseIdentifier: home_cell)
        //课程
        tableView.register(UINib.init(nibName: course_cell, bundle: nil), forCellReuseIdentifier: course_cell)
        
        refreshData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name.init("refresh"), object: nil)
    }
    
   @objc func refreshData(){
        
        if index == 0 {
            
            self.tableView.estimatedRowHeight = 100
            self.tableView.rowHeight = UITableView.automaticDimension
            
            //晒图
            loadSTModel()
        }else if index == 1{
            
            //活动
            loadHomeModel()
        }else{
            
            //课程
            loadCourseModel()
        }
    }

    //post_homeById
    //活动请求
    func loadHomeModel(){
        
        self.datas.removeAll()
        self.view.makeToastActivity(.center)
        BmobTools.post_obtainActive(success: { (array) in
            self.view.hideToastActivity()
            self.tableView.reloadData()
            //循环请求
            for model:ActiveModel in array{
                
                BmobTools.post_homeById(homeId: (model.activeId)!, success: { (model) in
                    
                    self.datas.append(model)
                    self.tableView.reloadData()
                }, failure: { (error) in
                    
                    
                })
            }
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    //晒图请求
    func loadSTModel(){
        
        self.view.makeToastActivity(.center)
        //post_stbyId
        BmobTools.post_stbyId(success: { (array) in
            self.view.hideToastActivity()
            self.stDatas = array
            self.tableView.reloadData()
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    //课程请求
    func loadCourseModel(){
        
        self.kcDatas.removeAll()
        //post_careCourse
        self.view.makeToastActivity(.center)
        BmobTools.post_careCourse(success: { (array) in
            
            self.view.hideToastActivity()
            self.tableView.reloadData()
            for model:ClubCourseBMModel in array{
                
                //post_clubCourseById
                BmobTools.post_clubCourseById((model.courseId)!, success: { (model) in
                    
                    self.kcDatas .append(model)
                    self.tableView.reloadData()
                }, failure: { (error) in
                    
                    
                })
            }
            
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if index == 0 {
            
            return self.stDatas.count
        }else if index == 1{
            
            return self.datas.count
        }else{
            
            return self.kcDatas.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if index == 0 {
            
            let cell:STCell = tableView.dequeueReusableCell(withIdentifier: st_cell, for: indexPath) as! STCell
            cell.model = self.stDatas[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else if index == 1{
            
            let cell:HomeCell = tableView.dequeueReusableCell(withIdentifier: home_cell, for: indexPath) as! HomeCell
            cell.cancelBtn.isHidden = false
            cell.model = self.datas[indexPath.row]
            return cell
            
        }else{
            
            let cell:CourseCell = tableView.dequeueReusableCell(withIdentifier: course_cell, for: indexPath) as! CourseCell
            cell.bmBtn.isSelected = true
            cell.model = self.kcDatas[indexPath.row]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if index == 0 {
            
            return UITableView.automaticDimension
        }else if index == 1{
            
            return 110
        }else{
            
            return 120
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if index == 0 {
            
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let detail:STDetailController = story.instantiateViewController(withIdentifier: "st_detail") as! STDetailController
            detail.model = self.stDatas[indexPath.row]
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
            
        }else if index == 1{
            
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let detail:ActiveDetailViewController = story.instantiateViewController(withIdentifier: "active_detail") as! ActiveDetailViewController
            detail.homeModel = self.datas[indexPath.row]
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
            
        }else{
            
            
        }
    }
}
