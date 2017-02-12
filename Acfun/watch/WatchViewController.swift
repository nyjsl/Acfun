//
//  WatchViewController.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/18.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
//关注
class WatchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavBar()
    }
    
    private func setNavBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let watchNav = WatchNavBar.generate(){
            
            var frame = watchNav.frame
            frame.size.width = Constants.SCREEN_FRAME.size.width
            watchNav.frame = frame
            self.navigationController?.view.addSubview(watchNav)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
