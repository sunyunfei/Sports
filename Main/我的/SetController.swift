//
//  SetController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/18.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit
import Photos
class SetController: UITableViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    var iconStr:String = ""
    var user:UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "修改信息"
        
        //显示数据
        user = SportsTools.obtainUser()
        if let u:UserModel = user {
            
            //icon.kf.setImage(with: URL.init(string: (u.icon)!))
            icon.sd_setImage(with: URL.init(string: (u.icon)!), completed: nil)
            iconStr = (u.icon)!
            nameField.text = u.name
            ageField.text = u.age
        }
        
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(clickIcon))
        
        icon.isUserInteractionEnabled = true
        icon.addGestureRecognizer(tap)
    }

    @IBAction func clickSubmitBtn(_ sender: Any) {
        
        
        //判断姓名是否有
        let name:String = (nameField.text)!
        if name.count <= 0 {
            
            self.view.makeToast("请输入姓名")
            return
        }
        
        //开始上传
        let age:String = (ageField.text)!
        if age.count <= 0 {
            
            self.view.makeToast("请输入年龄")
            return
        }
        
        if let u = user{
            
            u.age = age
            u.name = name
            self.view.makeToastActivity(.center)
            UserTools.post_updateUser(u, success: {
                self.view.hideToastActivity()
                
                self.navigationController?.popViewController(animated: true)
            }) { (error) in
                
                self.view.hideToastActivity()
                self.view.makeToast(error)
            }
        }
        
    }
    
    //选择投降
    @objc func clickIcon(){
        
        let album = JDAlbumGroupController()
        album.selectImgsClosure1 = { [weak self] (assets: [PHAsset]) in
            
            for index in 0..<assets.count {
                
                self?.getLitImage(asset: assets[index], callback: { (image) in
                    self?.icon.image = image
                    //上传
                    let data:Data? = image?.pngData()
                    
                    if let d = data{
                        
                        self?.view.makeToastActivity(.center)
                        UserTools.post_data(d, success: { (name) in
                            
                            self?.view.hideToastActivity()
                            self?.user?.icon = name
                        }, failure: { (error) in
                            
                            self?.view.hideToastActivity()
                            self?.view.makeToast(error)
                        })
                    }
                })
            }
        }
        
        let nav = UINavigationController(rootViewController: album)
        
        self.present(nav, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    typealias ImgCallBackType = (UIImage?)->()
    //获取缩略图
    private func getLitImage(asset: PHAsset,callback: @escaping ImgCallBackType){
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: CGSize(width: 100, height: 100) , contentMode: .aspectFill,
                                              options: nil, resultHandler: {
                                                (image, _: [AnyHashable : Any]?) in
                                                if image != nil{
                                                    callback(image)
                                                }
                                                
        })
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
    }
}
