//
//  ChildChannelCollectionViewCell.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/11.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class ChildChannelCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstranit: NSLayoutConstraint!
    
    var childChannel: ChildChannel?{
        didSet{
            if let c = childChannel{
                
                if let name = c.name{
                    channelTitleLabel.text = name
                }
            }
        }
    }
    
    var row: Int = 0{
        didSet{
            if row % 3 == 0{
                leadingConstraint.constant = 10
                trailingConstranit.constant = 0
            }else if row % 3 == 1{
                leadingConstraint.constant = 2
                trailingConstranit.constant = 2
            }else if row % 3 == 2{
                leadingConstraint.constant = 0
                trailingConstranit.constant = 10
            }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
