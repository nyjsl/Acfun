//
//  Contants.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/19.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation

struct Constants {
    
    static let PRIMARY_COLOR =  UIColor(colorLiteralRed: 253/255, green: 76/255, blue: 91/255, alpha: 1)
    
//    static var SCREEN_FRAME_WITHOUT_STATUSBAR:CGRect!
    
    static var SCREEN_FRAME:CGRect!  //(0.0, 0.0, 414.0, 736.0)

    static var STATUSBAR_FRAME:CGRect! //(0.0, 0.0, 414.0, 20.0)
    
    static var NAVIGATIONBAR_FRAME:CGRect!  //(0.0, 0.0, 414.0, 44.0)
    
    
    struct CellIdentifier {
        static let IndexCollectionViewCellArticleIndentifier = "IndexCollectionViewCellArticle"
    }

}
