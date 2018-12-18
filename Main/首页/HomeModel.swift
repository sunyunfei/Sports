//
//  HomeModel.swift
//  sports
//
//  Created by --- on 2018/12/10.
//  Copyright © 2018 李帅. All rights reserved.
//

import UIKit

class HomeModel: NSObject {

    var name:String?//名称
    var imageName:String?//图片名称
    var homeId:String?//id
    var intro:String?//简介
    var type:Bool?//类别
    var time:String?//时间
}


class HomeDetail: NSObject {
    
    var attention:String?//收藏
    var detail:String?//描述
    var homeId:String?//id
}


class ActiveModel: NSObject {
    
    var userId:String?//id
    var activeId:String?//id
    var name:String?//活动名称
}

