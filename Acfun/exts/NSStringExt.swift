//
//  UITextViewExt.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/8.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation

extension NSString{
    /*
     *返回值是该字符串所占的大小(width, height)
     *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
     *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
     */
    func sizeWithFont(font: UIFont,maxSize:CGSize) -> CGSize{
        
        let attrubutes = [NSFontAttributeName:font]
        return boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrubutes, context: nil).size
    }
}

