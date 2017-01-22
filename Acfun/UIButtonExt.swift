//
//  UIButtonExt.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/22.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation


extension UIButton{
    
    func changeButtonImageWithTintColor(tintColor: UIColor = UIColor.white,image: UIImage){
        self.tintColor = tintColor
        let imgChanged = image.withRenderingMode(.alwaysTemplate)
        self.setImage(imgChanged, for: .normal)
    }
}
