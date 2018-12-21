//
//  STCreateControllerViewController.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/21.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit
import Photos
class STCreateViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var textView: UITextView!
    var iconStr:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "创建晒图"
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(clicktap))
        icon.isUserInteractionEnabled = true
        icon.addGestureRecognizer(tap)
        
        
    }
    
    
    @objc func clicktap(){
        
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
                            self?.iconStr = name
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
    
    
    @IBAction func clickSubmit(_ sender: Any) {
        
        //判断字符
        //判断姓名是否有
        let name:String = (textView.text)!
        if name.count <= 0 {
            
            self.view.makeToast("请输入文字")
            return
        }
        
        let model:STModel = STModel()
        model.intro = name
        model.icon = iconStr
        let user:UserModel? = SportsTools.obtainUser()
        if let u:UserModel = user {
            
            if let s = u.name{
                
                model.userName = s
            }
        }
        
        self.view.makeToastActivity(.center)
        BmobTools.post_createST(model, success: {
            self.view.hideToastActivity()
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            
            self.view.hideToastActivity()
            self.view.makeToast(error)
        }
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
    
}
