//
//  ViewController.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/2.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //test channels
        let observable:Observable<DataResponse<BaseChannel>> = RxProvider<APIAcfun>.requestObject(target: .channels)
        let _ = observable.subscribe(onNext: { (dataResponse) in
            print(dataResponse.result.value?.message ?? "")
            print("2\(Thread.current)")

        }, onError: nil ,onCompleted: nil, onDisposed: nil)        //test channels
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

