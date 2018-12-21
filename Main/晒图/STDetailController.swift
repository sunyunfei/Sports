//
//  STDetailController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/21.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class STDetailController: UITableViewController {

    
    @IBOutlet weak var plBtn: UIButton!
    @IBOutlet weak var icon: UIImageView!
    var datas:Array<String> = Array()
    var sDatas:Array<STPLModel> = Array()
    var model:STModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "晒图详情"
        SportsTools.cutEvent(plBtn, true, 32, 1, UIColor.red)

        icon.sd_setImage(with: URL.init(string: (model?.icon)!), completed: nil)
        datas.append("配文：" + (model?.intro)!)
        datas.append("发布时间：" + (model?.time)!)
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.tableView.reloadData()
        loadData()
    }
    
    //评论
    @IBAction func clickPL(_ sender: Any) {
        
        //初始化UITextField
        var inputText:UITextField = UITextField();
        let msgAlertCtr = UIAlertController.init(title: "提示", message: "请输入评论", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style:.default) { (action:UIAlertAction) ->() in
            if((inputText.text) != nil){
                print("你输入的是：\(String(describing: inputText.text))")
                
                self.view.makeToastActivity(.center)
                
                let model2:STPLModel = STPLModel()
                model2.stId = self.model?.stId
                model2.content = inputText.text
                BmobTools.post_createpl(model2, success: {
                    
                    self.view.hideToastActivity()
                    self.loadData()
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
    
    //数据加载
    func loadData(){
        
        self.view.makeToastActivity(.center)
        
        BmobTools.post_stpl((model?.stId)!, success: { (array) in
            
            self.view.hideToastActivity()
            
            self.sDatas = array
            
            self.tableView.reloadData()
            
            
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            return datas.count
        }
        
        return sDatas.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.textColor = UIColor.lightGray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.selectionStyle = .none
        if indexPath.section == 0{
            
            cell.textLabel?.text = datas[indexPath.row]
        }else{
            let sModel:STPLModel = sDatas[indexPath.row]
            let str:String = (sModel.userName)! + "评论:\n  " + (sModel.content)! + "\n\n" + (sModel.time)!
            
            cell.textLabel?.text = str
        }
        
        return cell;
    }

}
