//
//  RegisterViewController.swift
//  sports
//
//  Created by 李帅 on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class RegisterViewController: RootViewController {

    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        SportsTools.cutEvent(registerBtn, true, 4, 1, UIColor.white)
    }
    
    @IBAction func clickRegisterBtn(_ sender: Any) {
        
        self.view.endEditing(true)
        
        //判断是否输入正确
        
        let account:String = accountField.text!
        let pwd:String = pwdField.text!
        
        if account.count <= 0 || pwd.count <= 0 {
            
            self.view.makeToast("请输入账号或者密码")
            return
        }else if account.count < 6 || pwd.count < 6 {
            self.view.makeToast("账号或者密码最少为6位")
            return
        }
        
        self.view.makeToastActivity(.center)
        //请求bmob数据
        let bmob:BmobObject = BmobObject.init(className: "user")
        bmob.setObject(account, forKey: "account")
        bmob.setObject(pwd, forKey: "pwd")
        bmob.setObject(account, forKey: "name")
        bmob.setObject("20", forKey: "age")
        bmob.setObject("http://ec4.images-amazon.com/images/I/41l8obVvsHL._SL500_AA300_.jpg", forKey: "icon")
        bmob.saveInBackground { (success, error) in
            
            if success{
                self.view.hideToastActivity()
                //注册成功，返回登录
                self.navigationController?.popViewController(animated: true)
            }else{
                self.view.hideToastActivity()
                self.view.makeToast("注册失败")
            }
        }
    }
    
    //取消键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }

}
