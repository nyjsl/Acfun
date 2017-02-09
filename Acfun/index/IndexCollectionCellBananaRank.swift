//
//  IndexCollectionCellBananaRank.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/5.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage

class IndexCollectionCellBananaRank: UICollectionViewCell {

   
    @IBOutlet weak var lineView: UIView!
    //gif 图片
    @IBOutlet weak var thumbnailAnimatedImgView: YYAnimatedImageView!
    @IBOutlet weak var thumbnailView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rankImgView: UIImageView!
    @IBOutlet weak var bananaNumberLabel: UILabel!
    //普通图片
    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var upLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var content: (Region.Content)?{
        didSet{
            
            thumbnailView.borderWithRoundCorner()

            if let c = content{
                bindContentData(c: c)
            }
        }
    }
    
    private func bindContentData(c: Region.Content){
        if let imgUrl = c.image{
            loadGifOrNormalImg(imgUrl: imgUrl)
        }
        titleLabel.text = c.title!
        if let goldBanana = c.visit?.goldBanana{
            bananaNumberLabel.text = "\(goldBanana)"
        }else{
            bananaNumberLabel.text = "0"
        }
        if let upper = c.owner?.name{
            upLabel.text = "UP: \(upper)"
        }
    }
    
    private func loadGifOrNormalImg(imgUrl: String){
        let url = URL(string: imgUrl)
        if imgUrl.hasSuffix(".gif"){
            thumbnailImg.isHidden = true
            thumbnailAnimatedImgView.isHidden = false
            thumbnailAnimatedImgView.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
        }else{
            thumbnailImg.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
            thumbnailImg.isHidden = false
            thumbnailAnimatedImgView.isHidden = true
        }

    }
    
    var rankNo:Int = 0{
        didSet{
            let literal = rankNo<3 ? "\(rankNo+1)" : "other"
            rankImgView.image = UIImage(named: "icon_ranking_\(literal)")
            lineView.isHidden = (rankNo == 0) //显示隐藏 横线
        }
    }

}
