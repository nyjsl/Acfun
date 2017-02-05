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
    
    @IBOutlet weak var thumbnailAnimatedImgView: YYAnimatedImageView! //gif 图片
    @IBOutlet weak var thumbnailView: UIView! //普通图片
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rankImgView: UIImageView!
    
    @IBOutlet weak var bananaNumberLabel: UILabel!
    @IBOutlet weak var thumbnailImg: UIImageView!
    
    @IBOutlet weak var upLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var content: (Region.Content)?{
        didSet{
            
            setViewToRoundCorner()
            
            if let c = content{
                
                if let imgUrl = c.image{
                    
                    if imgUrl.hasSuffix(".gif"){
                        thumbnailImg.isHidden = true
                        thumbnailAnimatedImgView.isHidden = false
                        let url = URL(string: imgUrl)
                        thumbnailAnimatedImgView.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
                    }else{
                        let url = URL(string: imgUrl)
                        thumbnailImg.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
                        thumbnailImg.isHidden = false
                        thumbnailAnimatedImgView.isHidden = true
                    }
                   

                }
                titleLabel.text = c.title!
                bananaNumberLabel.text = "\(c.visit!.goldBanana!)"
                upLabel.text = c.owner!.name!
            }
        }
    }
    
    private func setViewToRoundCorner(){
        thumbnailView.layer.masksToBounds = true
        thumbnailView.layer.cornerRadius = 5 //圆角
        
        thumbnailView.layer.borderWidth = 0.5
        thumbnailView.layer.borderColor = UIColor.gray.cgColor //边框
        
//        YYAnimatedImageView
    }
    
    var rankNo:Int = 0{
        didSet{
            let literal = rankNo<3 ? "\(rankNo+1)" : "other"
            rankImgView.image = UIImage(named: "icon_ranking_\(literal)")
            lineView.isHidden = (rankNo == 0) //显示隐藏 横线
        }
    }

}
