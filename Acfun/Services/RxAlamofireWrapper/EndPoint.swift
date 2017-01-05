//
//  EndPoint.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/3.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
typealias Method = Alamofire.HTTPMethod
typealias EncodingType = Alamofire.ParameterEncoding
typealias DataResponse = Alamofire.DataResponse
typealias Mappable = ObjectMapper.Mappable
typealias URLEncoding = Alamofire.URLEncoding
typealias JSONEncoding = Alamofire.JSONEncoding


class EndPoint<Target: TargetType>{
    
}

extension EndPoint{
    
    func request(target:Target) -> Alamofire.DataRequest{
        let url = target.baseUrl.appendingPathComponent(target.path)
        return Alamofire.request(url, method: target.method, parameters: target.params, encoding: target.encoding, headers: target.headers)
        
    }
    
}
