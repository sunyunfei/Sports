//
//  UserModel.swift
//  sports
//
//  Created by --- on 2018/12/17.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class UserModel: NSObject,NSCoding {
    
    var intro:String?
    var userId:String?
    var icon:String?
    var name:String?
    var account:String?
    var age:String?
    
    override init() {
        
        
    }
    
    public func encode(with aCoder: NSCoder){
        
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(account, forKey: "account")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(intro, forKey: "intro")
    }
    
    required public init?(coder aDecoder: NSCoder){
        
        icon = aDecoder.decodeObject(forKey: "icon") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        account = aDecoder.decodeObject(forKey: "account") as? String
        age = aDecoder.decodeObject(forKey: "age") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        intro = aDecoder.decodeObject(forKey: "intro") as? String
    }
}



class UserTools: NSObject {
    
    
    static func post_updateUser(_ model:UserModel,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        //请求上传数据
        let bmob:BmobObject = BmobObject.init(outDataWithClassName: "user", objectId: model.userId)
        
        bmob.setObject(model.name, forKey: "name")
        bmob.setObject(model.icon, forKey: "icon")
        bmob.setObject(model.age, forKey: "age")
        
        bmob.updateInBackground(resultBlock: { (flag, error) in
            
            if flag{
                
                print("更新成功")
                SportsTools.saveUser(model)
                success();
            }else{
                
                failure((error?.localizedDescription)!);
            }
        })
        
    }
    
    //上传文件
    static func post_data(_ data:Data,success:@escaping ((String) ->()),failure:@escaping ((String) -> ())){
        
        let name:String = dateConvertString(date: Date(), dateFormat: "yyyy-MM-dd-HH:mm:ss") + ".png"
        let file:BmobFile = BmobFile.init(fileName: name, withFileData: data)
        
        file.save { (isSuccess, error) in
            
            if isSuccess{
                
                success(file.url);
                
            }else{
                
                failure((error?.localizedDescription)!)
            }
        }
    }
    
    
    static func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
}
