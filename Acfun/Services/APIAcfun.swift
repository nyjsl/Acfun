//
//  APIAcfun.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/3.
//  Copyright © 2017年 wx. All rights reserved.
//
import Foundation

enum APIAcfun{
    case channels
    case regions
}

extension APIAcfun:TargetType{
    var baseUrl: URL {
        return URL(string: "http://api.aixifan.com")!
    }
    
    var path: String{
        switch self {
        case .channels:
            return "/channels/allChannels"
        case .regions:
            return "/regions"
        }
    }
    
    var method: Method{
        return .get
    }
    
    var params: [String : Any]?{
        return nil
    }
    
    var encoding: EncodingType{
        return JSONEncoding()
    }
    
    var headers: [String : String]?{
        return [
            "appVersion":"4.3.3"
            ,"deviceType":"0"
            ,"market":"appstore"
            ,"productId":"2000"
            ,"resolution":"1242*2280"
            ,"udid":"BCBE66E6-2A75-439F-87F0-E74B3F24DCA0"
        ]
    }
}
