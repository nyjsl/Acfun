//
//  BangumiLoginView.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/12.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class BangumiLoginView: UIView {
    
    
    class func generate() -> BangumiLoginView?{
        
        return Bundle.main.loadNibNamed("BangumiLoginView", owner: nil, options: nil)?.first as! BangumiLoginView?
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
