//
//  BaseDataModel.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/3.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation
import ObjectMapper
class BaseDataModel<T:Mappable>:Mappable {
    
    required init?(map: Map) {
        //DO NOTHING
    }
    
    
    var code: Int?
    
    var data :T?
    
    var message: String?
    
    func mapping(map: Map) {
        data <- map["data"]
        code <- map["code"]
        message <- map["message"]
    }
}

