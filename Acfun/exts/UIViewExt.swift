//
//  UIViewExt.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/7.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation

extension UIView{
    
    
    func borderWithRoundCorner(cornerRadius: CGFloat = 5,borderWidth: CGFloat = 0.5,borderColor: CGColor = UIColor.gray.cgColor){
        roundCorner(cornerRadius: cornerRadius)
        coloredBorder(borderWidth: borderWidth, borderColor: borderColor)
    }
    
    func roundCorner(cornerRadius: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius //圆角
        
        
    }
    
    func coloredBorder(borderWidth: CGFloat,borderColor: CGColor ){
       
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor //边框
    }
}
