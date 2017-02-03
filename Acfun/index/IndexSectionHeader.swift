//
//  IndexSectionHeader.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/26.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage
class IndexSectionHeader: UICollectionReusableView {

    @IBOutlet weak var icomImg: UIImageView!
    
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    var titleText: String?{
        didSet{
            sectionTitle.text = titleText
        }
    }
    
    var iconImageUrl: String?{
        didSet{
            icomImg.yy_setImage(with: URL(string:iconImageUrl!), placeholder: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
