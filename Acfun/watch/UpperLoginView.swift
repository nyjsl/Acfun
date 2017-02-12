//
//  UpperLoginView.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/12.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class UpperLoginView: UIView {
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loginBtn.setBackgroundImage(#imageLiteral(resourceName: "bangumi_item_border_highlighted"), for: .highlighted)
        loginBtn.setTitleColor(UIColor.lightText, for: .highlighted)

    }
    
    class func generate() -> UpperLoginView?{
        
        return Bundle.main.loadNibNamed("UpperLoginView", owner: nil, options: nil)?.first as! UpperLoginView?
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
