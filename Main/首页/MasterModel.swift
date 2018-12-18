//
//  MasterModel.swift
//  sports
//
//  Created by --- on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class MasterModel: NSObject {

    
    var name:String?//名称
    var icon:String?//图片名称
    var masterId:String?//id
    var describe:String?//简介
    var attention:Int?//类别
}

//大师问答
class MasterQuestion: NSObject {
    
    var replay:String?//回复
    var question:String?//问题
    var masterId:String?//id
    var userName:String?//姓名
    var time:String?//时间
}

//大师视频
class MasterVideo: NSObject {
    
    var video:String?//视频
    var masterId:String?//id
    var image:String?//图片
}

//大师关注
class MasterCare: NSObject {
    
    var icon:String?//icon
    var masterId:String?//id
    var masterName:String?//id
    var userId:String?//用户ID
}
