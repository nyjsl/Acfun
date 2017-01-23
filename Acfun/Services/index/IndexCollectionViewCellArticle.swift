//
//  IndexCollectionViewCellArticle.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/23.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class IndexCollectionViewCellArticle: UICollectionViewCell {

    
    @IBOutlet weak var articleDividerLine: UIView!
    
    @IBOutlet weak var articleTypeLabel: UILabel!
    
    @IBOutlet weak var articleCommentCountLabel: UILabel!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    @IBOutlet weak var articleUpMasterLabel: UILabel!
    
    @IBOutlet weak var articleViewCountButton: UIButton!
    
        @IBOutlet weak var articleViewCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        articleDividerLine.isHidden  = true //需要隐藏的设置
    }

}
