//
//  IndexNavBar.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/19.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class IndexNavBar: UIView {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    
    
    @IBOutlet weak var acfunLogBtn: UIButton!
    
    
    @IBOutlet weak var navGameCenterBtn: UIButton!
    
    
    @IBOutlet weak var navDownloadBtn: UIButton!
    
    @IBOutlet weak var navHistoryBtn: UIButton!
    
    @IBOutlet weak var navSearchBtn: UIButton!
    
    
      override func awakeFromNib() {
        super.awakeFromNib()
        customInit()
    }
    
    class func generate() -> IndexNavBar? {
        let loadedList = Bundle.main.loadNibNamed("IndexNavBar", owner: nil, options: nil)
        if let list = loadedList{
            if let result = list.first as! IndexNavBar?{
                return result
            }
        }
        return nil
    }
    
    private func customInit(){
        setFrameAndBackgroundImg()
        setNavItemButtons()
    }
    
    private func setFrameAndBackgroundImg(){
        let x = Constants.NAVIGATIONBAR_FRAME.origin.x
        let y = Constants.STATUSBAR_FRAME.origin.y
        let width = Constants.NAVIGATIONBAR_FRAME.size.width
        let height = Constants.NAVIGATIONBAR_FRAME.size.height +  Constants.STATUSBAR_FRAME.size.height
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        self.backgroundImg.image = #imageLiteral(resourceName: "ac_navigationbar")
    }
    
    var indexNavBarButtonDeleget: IndexNavBarButtonsDelegate?{
        didSet{
             setButtuonActionDelegate()
        }
    }
    
    private func setNavItemButtons(){
        self.navSearchBtn.changeButtonImageWithTintColor(image: #imageLiteral(resourceName: "icon_3dtouch_search"))
        self.navHistoryBtn.changeButtonImageWithTintColor(image: #imageLiteral(resourceName: "nav_history"))
        self.navDownloadBtn.changeButtonImageWithTintColor(image: #imageLiteral(resourceName: "nav_download"))
        self.navGameCenterBtn.changeButtonImageWithTintColor(image:#imageLiteral(resourceName: "ac_ipad_nav_bar_game"))
        self.acfunLogBtn.changeButtonImageWithTintColor(image: #imageLiteral(resourceName: "image_logo"))
        setButtuonActionDelegate()
    }
    
    private func setButtuonActionDelegate(){
        if let deleget = indexNavBarButtonDeleget{
            //由于协议设置的是可选方法,所以这里判断方法被实现后才设置到selector中
            if let _ = deleget.downloadAction{
                self.navDownloadBtn.addTarget(deleget, action:#selector(deleget.downloadAction), for: .touchUpInside)
            }
            if let _ = deleget.gameCenterAction{
                self.navGameCenterBtn.addTarget(deleget, action: #selector(deleget.gameCenterAction), for: .touchUpInside)
            }
            
            if let _ = deleget.historyAction{
                self.navHistoryBtn.addTarget(deleget, action: #selector(deleget.historyAction), for: .touchUpInside)
            }
            
            if let _ =  deleget.searchAction{
                self.navSearchBtn.addTarget(deleget, action: #selector(deleget.searchAction), for: .touchUpInside)
            }
            
        }
    }
    
}

@objc protocol IndexNavBarButtonsDelegate {
    @objc optional func gameCenterAction()
    @objc optional func historyAction()
    @objc optional func downloadAction()
    @objc optional func searchAction()
}
