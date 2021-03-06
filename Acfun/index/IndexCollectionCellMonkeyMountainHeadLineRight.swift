//
//  IndexCollectionViewCellMonkeyMountainHeadLineRightCollectionViewCell.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/4.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage
class IndexCollectionCellMonkeyMountainHeadLineRight: UICollectionViewCell {

    @IBOutlet weak var thumbnailView: UIView!
    @IBOutlet weak var animatedThumbnailImg: YYAnimatedImageView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var commentsBtn: UIButton!
    @IBOutlet weak var viewsBtn: UIButton!
    @IBOutlet weak var thumbnailImg: UIImageView!
    
    var monkeyMountainHeadlinContent: Region.Content?{
        didSet{
            //圆角
            thumbnailView.borderWithRoundCorner()
            viewsBtn.changeButtonImageWithTintColor(image: #imageLiteral(resourceName: "icon_grey_play"))
            commentsBtn.changeButtonImageWithTintColor(image: #imageLiteral(resourceName: "icon_grey_barrage"))
            if let content = monkeyMountainHeadlinContent{
                if let title = content.title{
                    titleLabel.text = title
                }
                if let views = content.visit?.views{
                    viewsLabel.text = "\(views)"
                }else{
                    viewsLabel.text = "0"
                }
                if let comments = content.visit?.comments{
                    commentsLabel.text = "\(comments)"
                }else{
                    commentsLabel.text = "0"
                }
                if let imgUrl = content.image{
                    loadGifOrNormalImg(imgUrl: imgUrl)
                }
            }
        }
    }
    
    private func loadGifOrNormalImg(imgUrl:String){
        let url = URL(string: imgUrl)
        if imgUrl.hasSuffix(".gif"){
            thumbnailImg.isHidden = true
            animatedThumbnailImg.isHidden = false
            animatedThumbnailImg.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
        }else{
            thumbnailImg.isHidden = false
            animatedThumbnailImg.isHidden = true
            thumbnailImg.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
        }

    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
