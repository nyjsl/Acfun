//
//  WatchNavBar.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/12.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class WatchNavBar: UIView {

    
    @IBOutlet weak var bangumiBtn: UIButton!
    
    @IBOutlet weak var upperBtn: UIButton!
    @IBOutlet weak var indicatorImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        indicatorImg.roundCorner(cornerRadius: 2)
        
        bangumiBtn.addTarget(self, action: #selector(swithcAction(sender:)), for: .touchUpInside)
        upperBtn.addTarget(self, action: #selector(swithcAction(sender:)), for: .touchUpInside)
        
           }
    
    
    @objc private func swithcAction(sender: UIButton){
        if sender === bangumiBtn{
            if !indicatorImg.transform.isIdentity{
                transformBack()
            }
        }else if sender === upperBtn{
            
            if indicatorImg.transform.isIdentity {
                transfromTo()
            }

        }
    }
    
    
    private func transfromTo(){
        let translationX = upperBtn.center.x - bangumiBtn.center.x
        let transFormUpper =  CGAffineTransform(translationX: translationX, y: 0)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.indicatorImg.transform = transFormUpper
        }, completion:nil)

    }
    
    private func transformBack(){
       UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
             self.indicatorImg.transform = .identity
        }, completion:nil)
    }
    
    class func generate() -> WatchNavBar?{
        return Bundle.main.loadNibNamed("WatchNavBar", owner: nil, options: nil)?.first as! WatchNavBar?
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
