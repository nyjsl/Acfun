//
//  IndexCollectionCellBagiums.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/6.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage
import SnapKit
class IndexCollectionCellBagiums: UICollectionViewCell {

   
    
    @IBOutlet weak var followerBgView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
  
    @IBOutlet weak var thumbnailImg: UIImageView!
    
    @IBOutlet weak var animatedThumbnailImg: YYAnimatedImageView!
    
    @IBOutlet weak var followerNoLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var thumbnailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var row:Int = 0 {
        didSet{
            if row % 3 == 0{
                leadingConstraint.constant = 10
                trailingConstraint.constant = 0
            }else if row % 3 == 1{
                leadingConstraint.constant = 0
                trailingConstraint.constant = 0
            }else if row % 3 == 2{
                leadingConstraint.constant = 0
                trailingConstraint.constant = 10
            }
            
            if row>2{
                topConstraint.constant = 0
            }else{
                topConstraint.constant = 5
            }
        }
        
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
                
                var stowNo = 0
                if let stoNo = c.visit?.stows{
                    stowNo = stoNo
                }
                let flowerStr: NSString = "\(stowNo)人追" as NSString
                followerNoLabel.text = flowerStr as String
                let _ = flowerStr.sizeWithFont(font:                 followerNoLabel.font, maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
                addBgImgToFollowerView()
               
            }
        }
    }
    
    private func addBgImgToFollowerView(){
        let bgImage = #imageLiteral(resourceName: "barrage_bg")
        let bgUIImageView = UIImageView(frame: followerBgView.bounds)
        bgUIImageView.image = bgImage
        bgUIImageView.autoresizingMask = .flexibleWidth
        followerBgView.insertSubview(bgUIImageView, at: 0)
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
