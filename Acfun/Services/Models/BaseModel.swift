//
//  BaseModel.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/4.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation
import ObjectMapper
class BaseModel:Mappable {
    
    required init?(map: Map) {
        //DO NOTHING
    }
    
    var code: Int?
    
    var message: String?
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}
