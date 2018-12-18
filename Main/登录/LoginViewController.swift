//
//  LoginViewController.swift
//  sports
//
//  Created by 李帅 on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class LoginViewController: RootViewController {

    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        SportsTools.cutEvent(loginBtn, true, 4, 1, UIColor.white)
        SportsTools.cutEvent(registerBtn, true, 4, 1, loginBtn.backgroundColor!)
        
    }
    

    
    @IBAction func clickLoginBtn(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let account:String = accountField.text!
        let pwd:String = pwdField.text!
        
        if account.count <= 0 || pwd.count <= 0 {
            
            self.view.makeToast("请输入账号或者密码")
            return
        }
        
        //网络请求
        self.view.makeToastActivity(.center)
        let bquery:BmobQuery = BmobQuery.init(className: "user")
        bquery.whereKey("account", equalTo: account)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                self.view.hideToastActivity()
                self.view.makeToast("无效账户")
            }else{
                
                if (array?.count)! > 0{
                    let obj:BmobObject = array?[0] as! BmobObject
                    let pwd2:String = obj.object(forKey: "pwd") as! String
                    //判断是否相等
                    if pwd2 == pwd{
                        
                        //说明登录成功
                        let model:UserModel = UserModel()
                        model.name = obj.object(forKey: "name") as? String
                        model.account = account
                        model.icon = obj.object(forKey: "icon") as? String
                        model.age = obj.object(forKey: "age") as? String
                        model.intro = obj.object(forKey: "intro") as? String
                        model.userId = obj.objectId
                        SportsTools.saveUser(model)
                        
                        //存储账号
                        let d:UserDefaults = UserDefaults.init()
                        d.set(account, forKey: "location_user")
                        d.synchronize()
                        self.view.hideToastActivity()
                        //退出
                        self.dismiss(animated: true, completion: nil)
                        
                    }else{
                        self.view.hideToastActivity()
                        self.view.makeToast("账号或者密码错误")
                    }
                }else{
                    self.view.hideToastActivity()
                    self.view.makeToast("登录失败")
                }
            }
        }
    }
    
    @IBAction func clickRegisterBtn(_ sender: Any) {
        self.view.endEditing(true)
        
        let story:UIStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
        let register:RegisterViewController = story.instantiateViewController(withIdentifier: "register") as! RegisterViewController
        register.title = "注册"
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    
    //取消键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}
