//
//  TargetType.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/3.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation

protocol TargetType {
    
    var baseUrl: URL {get}
    
    var path: String {get}
    
    var method: Method {get}
    
    var params: [String:Any]? {get}
    
    var encoding: EncodingType {get}
    
    var headers: [String:String]? {get}
}
