//
//  IndexNavBar.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/19.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class IndexNavBar: UIView {
    
    @IBOutlet weak var title: UILabel!
    
//    override func awakeFromNib() {
//    }
   
    
    class func generate() -> IndexNavBar? {
        let loadedList = Bundle.main.loadNibNamed("IndexNavBar", owner: nil, options: nil)
        if let list = loadedList{
            if let result = list.first as! IndexNavBar?{
                return result

            }
        }
        return nil
    }
}
