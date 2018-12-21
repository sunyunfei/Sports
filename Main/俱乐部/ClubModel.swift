//
//  ClubModel.swift
//  Sports
//
//  Created by 孙云飞 on 2018/12/21.
//  Copyright © 2018 syf. All rights reserved.
//

import UIKit

class ClubModel: NSObject {
    var icon:String?
    var name:String?
    var address:String?
    var intro:String?
    var time:String?
    var clubId:String?
    var video:String?
    var coach:String?
}

class ClubCourseModel: NSObject {
    
    var name:String?
    var intro:String?
    var clubId:String?
    var coach:String?
    var courseId:String?
}


class ClubCourseBMModel: NSObject {
    
    var name:String?
    var intro:String?
    var userId:String?
    var coach:String?
    var courseId:String?
}
