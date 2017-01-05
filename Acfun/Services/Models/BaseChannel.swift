//
//  BaseChannel.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/4.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation
import ObjectMapper
class BaseChannel:BaseModel {
    
    var data: [ChildChannel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
