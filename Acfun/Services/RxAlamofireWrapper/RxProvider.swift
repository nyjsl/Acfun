//
//  RxProvider.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/3.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation
import RxSwift
import AlamofireObjectMapper

//RxProvider
class RxProvider<Target:TargetType>{
    
    static var bgScheduler:OperationQueueScheduler!{
        get{
            let operationQueue = OperationQueue()
            operationQueue.maxConcurrentOperationCount = 3
            operationQueue.qualityOfService = .userInitiated
            return OperationQueueScheduler(operationQueue:operationQueue)
        }
    }
    
}

extension RxProvider{
    
        class func requestObject<T:Mappable>(target:Target) -> Observable<DataResponse<T>>{
        
        return Observable.create({ (observer) -> Disposable in
            
            let request = EndPoint<Target>().request(target: target)
            
            request.responseObject(completionHandler: { (response:DataResponse<T>) in
                
                if let error = response.result.error{
                    observer.onError(error)
                }else{
                    observer.onNext(response)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                request.cancel()
            }
        }).subscribeOn(bgScheduler)
    }
    
}
