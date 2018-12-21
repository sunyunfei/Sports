//
//  BmobTools.swift
//  sports
//
//  Created by 李帅 on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class BmobTools: NSObject {

    
    //首页请求接口
    static func post_home(success:@escaping ((Array<HomeModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "home")
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var homeArrays:Array<HomeModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:HomeModel = HomeModel()
                    model.homeId = obj.object(forKey: "homeId") as? String
                    model.name = obj.object(forKey: "name") as? String
                    model.imageName = obj.object(forKey: "imageName") as? String
                    model.intro = obj.object(forKey: "intro") as? String
                    model.type = obj.object(forKey: "type") as? Bool
                    let date:Date = obj.createdAt
                    model.time = self.dateConvertString(date: date, dateFormat: "yyyy-MM-dd hh:mm:ss")
                    homeArrays.append(model)
                }
                
                success(homeArrays)
            }
        }
    }
    
    //首页请求接口
    static func post_homeById(homeId:String,success:@escaping ((HomeModel) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "home")
        bquery.whereKey("homeId", equalTo: homeId)
        
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                let model:HomeModel = HomeModel()
                for obj:BmobObject in rArray{
                    
                    model.homeId = obj.object(forKey: "homeId") as? String
                    model.name = obj.object(forKey: "name") as? String
                    model.imageName = obj.object(forKey: "imageName") as? String
                    model.intro = obj.object(forKey: "intro") as? String
                    model.type = obj.object(forKey: "type") as? Bool
                    let date:Date = obj.createdAt
                    model.time = self.dateConvertString(date: date, dateFormat: "yyyy-MM-dd hh:mm:ss")
                }
                
                success(model)
            }
        }
    }
    
    //大师列表
    static func post_master(success:@escaping ((Array<MasterModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "homeMaster")
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<MasterModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:MasterModel = MasterModel()
                    model.masterId = obj.object(forKey: "masterId") as? String
                    model.name = obj.object(forKey: "name") as? String
                    model.icon = obj.object(forKey: "icon") as? String
                    model.describe = obj.object(forKey: "describe") as? String
                    model.attention = obj.object(forKey: "attention") as? Int
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //比赛列表
    static func post_game(success:@escaping ((Array<GameModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "homeGame")
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<GameModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:GameModel = GameModel()
                    model.gameId = obj.object(forKey: "gameId") as? String
                    model.name = obj.object(forKey: "name") as? String
                    model.imageName = obj.object(forKey: "imageName") as? String
                    model.intro = obj.object(forKey: "intro") as? String
                    model.apply = obj.object(forKey: "apply") as? Int
                    model.address = obj.object(forKey: "address") as? String
                    model.startTime = obj.object(forKey: "startTime") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    
    //大师问答
    static func post_masterQuestion(_ masterId:String,success:@escaping ((Array<MasterQuestion>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "materQuestion")
        bquery.whereKey("masterId", equalTo: masterId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<MasterQuestion> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:MasterQuestion = MasterQuestion()
                    model.replay = obj.object(forKey: "replay") as? String
                    model.userName = obj.object(forKey: "userName") as? String
                    model.question = obj.object(forKey: "question") as? String
                    model.masterId = obj.object(forKey: "masterId") as? String
                    
                    let date:Date = obj.createdAt
                    model.time = self.dateConvertString(date: date, dateFormat: "yyyy-MM-dd hh:mm:ss")
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    
    //提交提问
    static func post_submitMasterQuestion(_ model:MasterQuestion,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        //materQuestion
        let obj:BmobObject = BmobObject.init(className: "materQuestion")
        obj.setObject(model.masterId, forKey: "masterId")
        obj.setObject(model.question, forKey: "question")
        obj.setObject(model.userName, forKey: "userName")
        obj.saveInBackground { (flag, error) in
            if flag{
                
                success()
                
            }else{
                
                failure((error?.localizedDescription)!)
            }
        }
    }
    
    
    //大师视频
    static func post_masterVideo(_ masterId:String,success:@escaping ((Array<MasterVideo>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "masterVideo")
        bquery.whereKey("masterId", equalTo: masterId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<MasterVideo> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:MasterVideo = MasterVideo()
                    
                    model.masterId = obj.object(forKey: "apply") as? String
                    model.video = obj.object(forKey: "video") as? String
                    model.image = obj.object(forKey: "image") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //获取关注的大师
    static func post_obtainCareMaster(success:@escaping ((Array<MasterCare>) ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        let bquery:BmobQuery = BmobQuery.init(className: "master_attention")
        bquery.whereKey("userId", equalTo: account)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<MasterCare> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:MasterCare = MasterCare()
                    
                    model.masterId = obj.object(forKey: "masterId") as? String
                    model.masterName = obj.object(forKey: "masterName") as? String
                    model.icon = obj.object(forKey: "icon") as? String
                    model.userId = obj.object(forKey: "userId") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //关注大师
    static func post_careMaster(_ model:MasterModel,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        //先判断数据是否已经有对应的数据了
        post_obtainCareMaster(success: { (array) in
            
            var flag:Bool = false
            for obj:MasterCare in array{
                
                if obj.masterId == model.masterId{
                    
                    failure("已经关注过，无需再次关注")
                    flag = true
                    break
                }
            }
            
            if !flag{
                
                //materQuestion
                let obj:BmobObject = BmobObject.init(className: "master_attention")
                obj.setObject(model.masterId, forKey: "masterId")
                obj.setObject(model.icon, forKey: "icon")
                obj.setObject(model.name, forKey: "masterName")
                obj.setObject(account, forKey: "userId")
                obj.saveInBackground { (flag, error) in
                    if flag{
                        
                        success()
                        
                    }else{
                        
                        failure((error?.localizedDescription)!)
                    }
                }
            }
            
        }) { (error) in
            
            failure(error)
        }
        
    }
    
    
    //获取活动详情
    static func post_activeDetail(_ homeId:String,success:@escaping ((_ result:HomeDetail) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "homeDetail")
        bquery.whereKey("homeId", equalTo: homeId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                let model:HomeDetail = HomeDetail()
                for obj:BmobObject in rArray{
                    
                    model.homeId = obj.object(forKey: "homeId") as? String
                    model.attention = obj.object(forKey: "attention") as? String
                    model.detail = obj.object(forKey: "detail") as? String
                    
                }
                
                success(model)
            }
        }
    }
    
    
    //活动报名
    //获取报名的活动
    static func post_obtainActive(success:@escaping ((Array<ActiveModel>) ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        let bquery:BmobQuery = BmobQuery.init(className: "active_bm")
        bquery.whereKey("userId", equalTo: account)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<ActiveModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:ActiveModel = ActiveModel()
                    
                    model.userId = obj.object(forKey: "userId") as? String
                    model.activeId = obj.object(forKey: "activeId") as? String
                    model.name = obj.object(forKey: "name") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //删除报名的活动
    static func post_deleteActive(_ activeId:String,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        let bquery:BmobQuery = BmobQuery.init(className: "active_bm")
        bquery.whereKey("userId", equalTo: account)
        bquery.whereKey("activeId", equalTo: activeId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                for obj:BmobObject in rArray{
                    
                    obj.deleteInBackground({ (flag, error) in
                        
                        if flag{
                            
                            success()
                        }else{
                            
                            failure((error?.localizedDescription)!)
                        }
                    })
                }
            }
        }
    }
    
    //关注大师
    static func post_bmActive(_ model:HomeModel,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        //先判断数据是否已经有对应的数据了
        post_obtainActive(success: { (array) in
            
            var flag:Bool = false
            for obj:ActiveModel in array{
                
                if obj.activeId == model.homeId{
                    
                    failure("已经报名过这个活动了")
                    flag = true
                    break
                }
            }
            
            if !flag{
                
                //materQuestion
                let obj:BmobObject = BmobObject.init(className: "active_bm")
                obj.setObject(model.homeId, forKey: "activeId")
                obj.setObject(model.name, forKey: "name")
                obj.setObject(account, forKey: "userId")
                obj.saveInBackground { (flag, error) in
                    if flag{
                        
                        success()
                        
                    }else{
                        
                        failure((error?.localizedDescription)!)
                    }
                }
            }
            
        }) { (error) in
            
            failure(error)
        }
        
    }
    
    //获取训练列表
    static func post_xl(success:@escaping ((Array<XLModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "xl")
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<XLModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:XLModel = XLModel()
                    model.xlId = obj.objectId
                    model.name = obj.object(forKey: "name") as? String
                    model.icon = obj.object(forKey: "icon") as? String
                    model.intro = obj.object(forKey: "intro") as? String
                    model.time = obj.object(forKey: "time") as? String
                    model.address = obj.object(forKey: "address") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    
    
    //获取报名的训练
    static func post_obtainCareXL(success:@escaping ((Array<XLBMModel>) ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        let bquery:BmobQuery = BmobQuery.init(className: "user_xl")
        bquery.whereKey("userId", equalTo: account)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<XLBMModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:XLBMModel = XLBMModel()
                    
                    model.userId = obj.object(forKey: "userId") as? String
                    model.name = obj.object(forKey: "name") as? String
                    model.xlId = obj.object(forKey: "xlId") as? String
                    model.icon = obj.object(forKey: "icon") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //报名训练
    static func post_carexl(_ model:XLModel,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        //先判断数据是否已经有对应的数据了
        post_obtainCareXL(success: { (array) in
            
            var flag:Bool = false
            for obj:XLBMModel in array{
                
                if obj.xlId == model.xlId{
                    
                    failure("已经报名成功了,无需再次报名")
                    flag = true
                    break
                }
            }
            
            if !flag{
                
               
                let obj:BmobObject = BmobObject.init(className: "user_xl")
                obj.setObject(model.xlId, forKey: "xlId")
                obj.setObject(model.icon, forKey: "icon")
                obj.setObject(model.name, forKey: "name")
                obj.setObject(account, forKey: "userId")
                obj.saveInBackground { (flag, error) in
                    if flag{
                        
                        success()
                        
                    }else{
                        
                        failure((error?.localizedDescription)!)
                    }
                }
            }
            
        }) { (error) in
            
            failure(error)
        }
        
    }
    
    
    //获取提问
    static func post_tw(_ xlId:String,success:@escaping ((Array<XLASKModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "xl_ask")
        bquery.whereKey("xlId", equalTo: xlId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<XLASKModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:XLASKModel = XLASKModel()
                    model.userName = obj.object(forKey: "userName") as? String
                    model.replay = obj.object(forKey: "replay") as? String
                    model.xlId = obj.object(forKey: "xlId") as? String
                    model.ask = obj.object(forKey: "ask") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    
    //提交提问
    static func post_xltw(_ model:XLASKModel,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        //materQuestion
        let obj:BmobObject = BmobObject.init(className: "xl_ask")
        obj.setObject(model.xlId, forKey: "xlId")
        obj.setObject(model.ask, forKey: "ask")
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        obj.setObject(account, forKey: "userName")
        obj.saveInBackground { (flag, error) in
            if flag{
                
                success()
                
            }else{
                
                failure((error?.localizedDescription)!)
            }
        }
    }
    
    
    
    
    //俱乐部
    static func post_club(success:@escaping ((Array<ClubModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "club")
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<ClubModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:ClubModel = ClubModel()
                    model.clubId = obj.objectId
                    model.name = obj.object(forKey: "name") as? String
                    model.icon = obj.object(forKey: "icon") as? String
                    model.intro = obj.object(forKey: "intro") as? String
                    model.time = obj.object(forKey: "time") as? String
                    model.address = obj.object(forKey: "address") as? String
                    model.coach = obj.object(forKey: "coach") as? String
                    model.video = obj.object(forKey: "video") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //获取俱乐部课程
    static func post_clubCourse(_ clubId:String,success:@escaping ((Array<ClubCourseModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "clubcourse")
        bquery.whereKey("clubId", equalTo: clubId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<ClubCourseModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:ClubCourseModel = ClubCourseModel()
                    
                    model.intro = obj.object(forKey: "intro") as? String
                    model.name = obj.object(forKey: "name") as? String
                    model.coach = obj.object(forKey: "coach") as? String
                    model.clubId = obj.object(forKey: "clubId") as? String
                    model.courseId = obj.objectId;
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //根据课程id获取h课程
    static func post_clubCourseById(_ courseId:String,success:@escaping ((ClubCourseModel) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "clubcourse")
        
        bquery.getObjectInBackground(withId: courseId) { (obj, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let obj2:BmobObject = obj!
                
                let model:ClubCourseModel = ClubCourseModel()
                
                model.intro = obj2.object(forKey: "intro") as? String
                model.name = obj2.object(forKey: "name") as? String
                model.coach = obj2.object(forKey: "coach") as? String
                model.clubId = obj2.object(forKey: "clubId") as? String
                model.courseId = obj2.objectId;
               success(model)
            }
        }
        
    }
    
    //获取关注的课程
    static func post_careCourse(success:@escaping ((Array<ClubCourseBMModel>) ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        let bquery:BmobQuery = BmobQuery.init(className: "course_bm")
        bquery.whereKey("userId", equalTo: account)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<ClubCourseBMModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:ClubCourseBMModel = ClubCourseBMModel()
                    
                    model.intro = obj.object(forKey: "intro") as? String
                    model.name = obj.object(forKey: "name") as? String
                    model.coach = obj.object(forKey: "coach") as? String
                    model.userId = obj.object(forKey: "userId") as? String
                    model.courseId = obj.object(forKey: "courseId") as? String
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    
    //删除关注的课程
    static func post_deleteCareCourse(courseId:String,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        let bquery:BmobQuery = BmobQuery.init(className: "course_bm")
        bquery.whereKey("userId", equalTo: account)
        bquery.whereKey("courseId", equalTo: courseId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                for obj:BmobObject in rArray{
                    
                    obj.deleteInBackground({ (flag, error) in
                        
                        if flag {
                            
                            success()
                        }else{
                            
                            failure((error?.localizedDescription)!)
                        }
                    })
                }
            }
        }
    }
    
    //报名课程
    static func post_carecourse(_ model:ClubCourseModel,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        let d:UserDefaults = UserDefaults.init()
        let account:String? = d.object(forKey: "location_user") as? String
        
        //先判断数据是否已经有对应的数据了
        post_careCourse(success: { (array) in
            
            var flag:Bool = false
            for obj:ClubCourseBMModel in array{
                
                if obj.courseId == model.courseId{
                    
                    failure("已经报名成功了,无需再次报名")
                    flag = true
                    break
                }
            }
            
            if !flag{
                
                
                let obj:BmobObject = BmobObject.init(className: "course_bm")
                obj.setObject(model.courseId, forKey: "courseId")
                obj.setObject(model.intro, forKey: "intro")
                obj.setObject(model.name, forKey: "name")
                obj.setObject(account, forKey: "userId")
                obj.setObject(model.coach, forKey: "coach")
                
                obj.saveInBackground { (flag, error) in
                    if flag{
                        
                        success()
                        
                    }else{
                        
                        failure((error?.localizedDescription)!)
                    }
                }
            }
            
        }) { (error) in
            
            failure(error)
        }
        
    }
    
    
    
    //晒图列表
    static func post_st(success:@escaping ((Array<STModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "st")
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<STModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:STModel = STModel()
                    model.intro = obj.object(forKey: "intro") as? String
                    model.userName = obj.object(forKey: "userName") as? String
                    model.icon = obj.object(forKey: "icon") as? String
                    model.stId = obj.objectId
                    
                    let date:Date = obj.createdAt
                    model.time = self.dateConvertString(date: date, dateFormat: "yyyy-MM-dd hh:mm:ss")
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //晒图列表
    static func post_stbyId(success:@escaping ((Array<STModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "st")
        let user:UserModel? = SportsTools.obtainUser()
        bquery.whereKey("userId", equalTo: user?.userId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<STModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:STModel = STModel()
                    model.intro = obj.object(forKey: "intro") as? String
                    model.userName = obj.object(forKey: "userName") as? String
                    model.icon = obj.object(forKey: "icon") as? String
                    model.stId = obj.objectId
                    
                    let date:Date = obj.createdAt
                    model.time = self.dateConvertString(date: date, dateFormat: "yyyy-MM-dd hh:mm:ss")
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    //创建
    static func post_createST(_ model:STModel,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        //materQuestion
        let obj:BmobObject = BmobObject.init(className: "st")
        obj.setObject(model.intro, forKey: "intro")
        obj.setObject(model.icon, forKey: "icon")
        let user:UserModel? = SportsTools.obtainUser()
        if let u:UserModel = user {
            
            if let s = u.name{
                
                obj.setObject(s, forKey: "userName")
                
            }
        }
        obj.setObject(user?.userId, forKey: "userId")
        obj.saveInBackground { (flag, error) in
            if flag{
                
                success()
                
            }else{
                
                failure((error?.localizedDescription)!)
            }
        }
    }
    
    
    //晒图评论
    static func post_stpl(_ stId:String,success:@escaping ((Array<STPLModel>) ->()),failure:@escaping ((String) -> ())){
        
        let bquery:BmobQuery = BmobQuery.init(className: "st_pl")
        bquery.whereKey("stId", equalTo: stId)
        bquery.findObjectsInBackground { (array, error) in
            
            if error != nil{
                
                failure("数据请求失败")
            }else{
                
                let rArray:Array<BmobObject> = array as! Array<BmobObject>
                var mArrays:Array<STPLModel> = Array.init()
                for obj:BmobObject in rArray{
                    
                    let model:STPLModel = STPLModel()
                    model.content = obj.object(forKey: "content") as? String
                    model.userName = obj.object(forKey: "userName") as? String
                    model.stId = obj.objectId
                    
                    let date:Date = obj.createdAt
                    model.time = self.dateConvertString(date: date, dateFormat: "yyyy-MM-dd hh:mm:ss")
                    mArrays.append(model)
                }
                
                success(mArrays)
            }
        }
    }
    
    
    //提交评论
    static func post_createpl(_ model:STPLModel,success:@escaping (() ->()),failure:@escaping ((String) -> ())){
        
        let user:UserModel? = SportsTools.obtainUser()
        
        let obj:BmobObject = BmobObject.init(className: "st_pl")
        obj.setObject(model.content, forKey: "content")
        obj.setObject(model.stId, forKey: "stId")
        obj.setObject(user?.name, forKey: "userName")
        
        obj.saveInBackground { (flag, error) in
            if flag{
                
                success()
                
            }else{
                
                failure((error?.localizedDescription)!)
            }
        }
        
    }
    
    /// - Returns: 日期字符串
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
