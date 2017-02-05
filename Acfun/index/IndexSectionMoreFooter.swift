//
//  IndexSectionMoreFooterCollectionReusableView.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/4.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class IndexSectionMoreFooter: UICollectionReusableView {

    @IBOutlet weak var lineView: UIView!
    
    var title: String?{
        didSet{
            if let t = title{
                moreLabel.text = "更多\(t)内容"
            }
        }
    }
    
    func setLineViewIsHidden(isHidden: Bool){
        lineView.isHidden = isHidden
    }
    
    @IBOutlet weak var moreView: UIView!
    
    @IBOutlet weak var moreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
