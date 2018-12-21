//
//  XLDetailController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/18.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class XLDetailController: UITableViewController {

    var model:XLModel?
    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var askBtn: UIButton!
    @IBOutlet weak var icon: UIImageView!
    var datas:Array<String> = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        icon.sd_setImage(with: URL.init(string: (model?.icon)!), completed: nil)
        
        datas.append("训练名称：" + (model?.name)!)
        datas.append("训练时间：" + (model?.time)!)
        datas.append("训练地址：" + (model?.address)!)
        datas.append("训练介绍：\n" + (model?.intro)!)
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        self.tableView.reloadData()
    }

    //点击报名
    @IBAction func clickBMBtn(_ sender: Any) {
        
        self.view.makeToastActivity(.center)
        BmobTools.post_carexl(model!, success: {
            
            self.view.hideToastActivity()
            self.headView.makeToast("报名成功")
        }) { (error) in
            
            self.view.hideToastActivity()
            self.headView.makeToast(error)
        }
    }
    
    //点击提问
    @IBAction func clickSumbitBtn(_ sender: Any) {

        //初始化UITextField
        var inputText:UITextField = UITextField();
        let msgAlertCtr = UIAlertController.init(title: "提示", message: "请输入提问", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style:.default) { (action:UIAlertAction) ->() in
            if((inputText.text) != nil){
                print("你输入的是：\(String(describing: inputText.text))")
                
                self.view.makeToastActivity(.center)
                
                let xmodel:XLASKModel = XLASKModel()
                xmodel.xlId = self.model?.xlId
                xmodel.ask = inputText.text
                
                BmobTools.post_xltw(xmodel, success: {
                    
                    self.view.hideToastActivity()
                    self.headView.makeToast("提问成功")
                }) { (error) in
                    
                    self.view.hideToastActivity()
                    self.headView.makeToast(error)
                }
                
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
    //点击咨询
    @IBAction func clickAskBtn(_ sender: Any) {
        
        if let xiId = model?.xlId{
            
            let askVC:XLAskViewController = XLAskViewController()
            askVC.xlId = xiId
            self.navigationController?.pushViewController(askVC, animated: true)
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
        cell.textLabel?.text = datas[indexPath.row]
        
        return cell;
    }

}
