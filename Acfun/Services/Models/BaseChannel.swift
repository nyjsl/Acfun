//
//  BaseChannel.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/4.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation
import ObjectMapper
class BaseChannel:BaseDatasModel<ChildChannel> {
    
    
}
struct ChildChannel:Mappable {
        
    init?(map: Map) {
        //DO NOTHING
    }
    
    var childChannels: [ChildChannel]?
    var creator: Int?
    var dbstatus: Int?
    var hide: Int?
    var img: String?
    var name : String?
    var parents: String?
    var pid: Int?
    var priority: Int?
    var type: Int?
    var updater: Int?
    
    mutating func mapping(map: Map) {
        childChannels <- map["childChannels"]
        creator <- map["creator"]
        dbstatus <- map["dbstatus"]
        hide <- map["hide"]
        img <- map["img"]
        name <- map["name"]
        parents <- map["parents"]
        pid <- map["pid"]
        priority <- map["priority"]
        type <- map["type"]
        updater <- map["updater"]
    }
}

