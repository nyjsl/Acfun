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
    
    var content: (Region.Content)?{
        didSet{
            
            thumbnailView.borderWithRoundCorner()
            
            if let c = content{
                loadGifOrNormalImg(imgUrl: c.image!)
                titleLabel.text = c.title!
                let descStr = "更新至 \(c.latestBangumiVideo!.title!)"
                
                let attrString = NSMutableAttributedString(string:descStr)
                let range:NSRange = NSRange(location: 0,length:3)
                attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: range)
                let rangeEnd:NSRange = NSRange(location: 4, length: descStr.characters.count-4)
                
                attrString.addAttribute(NSForegroundColorAttributeName, value: Constants.PRIMARY_COLOR, range: rangeEnd)
                
                descLabel.attributedText = attrString
                
                
            }
        }
    }
    
    private func loadGifOrNormalImg(imgUrl: String){
        let url = URL(string: imgUrl)
        if imgUrl.hasSuffix(".gif"){
            thumbnailImg.isHidden = true
            animatedThumbnailImg.isHidden = false
            animatedThumbnailImg.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
        }else{
            thumbnailImg.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
            thumbnailImg.isHidden = false
            animatedThumbnailImg.isHidden = true
        }
        
    }

}
