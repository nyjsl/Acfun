//
//  MineHeaderView.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/15.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {

    
    
    @IBOutlet weak var avaterLabel: UIImageView!
    @IBOutlet weak var uNameLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loginBtn.borderWithRoundCorner(cornerRadius: 20, borderWidth: 1, borderColor: UIColor.white.cgColor)
        loginBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        avaterLabel.roundCorner(cornerRadius: avaterLabel.frame.size.width.divided(by: 2))
    
    }
    
    
    class func genereate() -> MineHeaderView?{
        return Bundle.main.loadNibNamed("MineHeaderView", owner: nil, options: nil)?.first as! MineHeaderView?
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
