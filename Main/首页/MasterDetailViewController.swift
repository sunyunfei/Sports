//
//  MasterDetailViewController.swift
//  sports
//
//  Created by --- on 2018/12/11.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

let detail_cell = "MasterQuestionCell"
class MasterDetailViewController: RootViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var introView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var careBtn: UIButton!
    
    var masterModel:MasterModel?
    
    var datas:Array<MasterQuestion> = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SportsTools.cutEvent(videoBtn, true, videoBtn.frame.size.height / 2, 1, UIColor.white)
        SportsTools.cutEvent(careBtn, true, videoBtn.frame.size.height / 2, 1, UIColor.white)
        
        introView.backgroundColor = UIColor.clear
        introView.endEditing(false)
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension

        tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: detail_cell, bundle: nil), forCellReuseIdentifier: detail_cell)
        tableView.tableFooterView = UIView.init()
        
        showData()
    }
    
    //信息展示
    func showData(){
        
        if let iconS = masterModel?.icon {
            
            //icon.kf.setImage(with: URL.init(string: iconS))
            icon.sd_setImage(with: URL.init(string: iconS), completed: nil)
        }
        
        nameLabel.text = masterModel?.name
        introView.text = masterModel?.describe
        
        loadData()
    }
    
    func loadData(){
        
        self.view.makeToastActivity(.center)
        BmobTools.post_masterQuestion((masterModel?.masterId)!, success: { (array) in
            
            self.view.hideToastActivity()
            self.datas = array
            self.tableView.reloadData()
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    //提问
    @IBAction func clickAskBtn(_ sender: Any) {
        
        //初始化UITextField
        var inputText:UITextField = UITextField();
        let msgAlertCtr = UIAlertController.init(title: "提示", message: "请输入问题", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style:.default) { (action:UIAlertAction) ->() in
            if((inputText.text) != nil){
                print("你输入的是：\(String(describing: inputText.text))")
                
                self.view.makeToastActivity(.center)
                
                let model:MasterQuestion = MasterQuestion()
                model.masterId = self.masterModel?.masterId
                model.question = inputText.text
                let d:UserDefaults = UserDefaults.init()
                let account:String? = d.object(forKey: "location_user") as? String
                model.userName = account
                
                BmobTools.post_submitMasterQuestion(model, success: {
                    
                    self.view.hideToastActivity()
                    self.showData()
                }, failure: { (error) in
                    
                    self.view.hideToastActivity()
                    self.view.makeToast(error)
                })
                
            }
        }
        
        let cancel = UIAlertAction.init(title: "取消", style:.cancel) { (action:UIAlertAction) -> ()in
            print("取消输入")
        }
        
        msgAlertCtr.addAction(ok)
        msgAlertCtr.addAction(cancel)
        //添加textField输入框
        msgAlertCtr.addTextField { (textField) in
            //设置传入的textField为初始化UITextField
            inputText = textField
            inputText.placeholder = "输入提问内容"
        }
        //设置到当前视图
        self.present(msgAlertCtr, animated: true, completion: nil)
    }
    
    
    //视频
    @IBAction func clickVideoBtn(_ sender: Any) {
        
        let vc:GameController = GameController()
        vc.isGame = false
        vc.masterId = masterModel?.masterId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //关注
    @IBAction func clickCareBtn(_ sender: Any) {
        
        self.view.makeToastActivity(.center)
        BmobTools.post_careMaster((self.masterModel)!, success: {
            
            self.view.hideToastActivity()
            self.view.makeToast("关注成功")
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MasterQuestionCell = tableView.dequeueReusableCell(withIdentifier: detail_cell, for: indexPath) as! MasterQuestionCell
        cell.selectionStyle = .none
        cell.model = datas[indexPath.row]
        return cell
    }

}
