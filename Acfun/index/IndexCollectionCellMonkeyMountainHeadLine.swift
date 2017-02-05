//
//  IndexCollectionCellMonkeyMountainHeadLine.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/3.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage

class IndexCollectionCellMonkeyMountainHeadLine: UICollectionViewCell {

    @IBOutlet weak var viewsBtn: UIButton!
    
    @IBOutlet weak var commentsBtn: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var thumbnailImg: UIImageView!
    
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    var monkeyMountainHeadlinContent: Region.Content?{
        didSet{
            //圆角
            thumbnailImg.layer.cornerRadius = 5
            thumbnailImg.layer.masksToBounds = true

            viewsBtn.changeButtonImageWithTintColor(image: #imageLiteral(resourceName: "icon_grey_play"))
            commentsBtn.changeButtonImageWithTintColor(image: #imageLiteral(resourceName: "icon_grey_barrage"))
            if let content = monkeyMountainHeadlinContent{
                titleLabel.text = content.title!
                viewsLabel.text = "\(content.visit!.views!)"
                commentsLabel.text = "\(content.visit!.comments!)"
                let url = URL(string: content.image!)
                thumbnailImg.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}