//
//  ChannelViewController.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/18.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import RxSwift
class ChannelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgitaionBar()
    }
    
    private func setupNavgitaionBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let channelNavBar = ChannelNavBar.generate(){
            self.navigationController?.view.addSubview(channelNavBar)

        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private func getChannels(){
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
