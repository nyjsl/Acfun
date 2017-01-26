//
//  IndexCollectionCellBanner.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/26.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage

//横幅Cell
class IndexCollectionCellBanner: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var bannerRegion: Region?{
        didSet{
            loadImage()
        }
    }
    
    private func loadImage(){
        bannerImage.yy_setImage(with: getImagUrl(), placeholder: #imageLiteral(resourceName: "image_view_default"))
    }
    
    
    private func getImagUrl() -> URL?{
        if let str = bannerRegion?.image {
            if !str.isEmpty{
                return URL(string: str)
            }
        }
        if let contents = bannerRegion?.contents{
            if contents.count>0{
                return URL(string: contents[0].image!)
            }
        }
        return nil
        
    }
    

}
