//
//  IndexCollectionCellBagiums.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/6.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage

class IndexCollectionCellBagiums: UICollectionViewCell {

    
  
    @IBOutlet weak var thumbnailImg: UIImageView!
    
    @IBOutlet weak var animatedThumbnailImg: YYAnimatedImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var thumbnailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
