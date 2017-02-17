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

    @IBOutlet weak var contentView: UIView!
    
    
    fileprivate lazy var bangumiView = {
        return BangumiLoginView.generate()!
    }()
    
    fileprivate lazy var upperView = {
       return UpperLoginView.generate()!
    }()
    
      override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavBar()
        
        setUpConetntView(bangumiView)
    }
    
    fileprivate func setUpConetntView(_ viewToShow:UIView){
        viewToShow.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height:contentView.bounds.size.height-Constants.TAB_BAR_FRAM.size.height )
        contentView.insertSubview(viewToShow, at: 0)

       
    }
    
    private func setNavBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let watchNav = WatchNavBar.generate(){
            watchNav.delegate = self
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

extension WatchViewController: WatchNavBarDelegate{
    
    func bangumiAction() {
        self.upperView.removeFromSuperview()
        self.setUpConetntView(bangumiView)
    }
    
    func upperAction() {
        self.bangumiView.removeFromSuperview()
        self.setUpConetntView(upperView)
    }
    
    func searchAction() {
        print("searchAction")
    }
    
}
