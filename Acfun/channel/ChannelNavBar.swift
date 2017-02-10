//
//  ChannelNavBar.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/10.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class ChannelNavBar: UIView {

   
    class func generate() -> ChannelNavBar?{
        let result = Bundle.main.loadNibNamed("ChannelNavBar", owner: nil, options: nil)?.first as! ChannelNavBar?
        return result
        
    }

}
