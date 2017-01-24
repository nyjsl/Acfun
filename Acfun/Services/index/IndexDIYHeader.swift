//
//  IndexDIYHeader.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/24.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation
class IndexDIYHeader: MJRefreshGifHeader{
    
    override func prepare() {
        super.prepare()
        setImages(idelHeaderImgs, for: .idle)
        setImages(idelHeaderImgs, for: .willRefresh)
        setImages(refreshingHeaderImgs, for: .refreshing)
        lastUpdatedTimeLabel.isHidden = true
        setTitle("松开刷新", for: .pulling)
        setTitle("下拉刷新", for: .idle)
        setTitle("内容加载...", for: .refreshing)
        self.labelLeftInset = 10
    }
    
    private let idelHeaderImgs = [#imageLiteral(resourceName: "ac_pull_swing_01")]
    //刷新
    private lazy var refreshingHeaderImgs:[UIImage] = {
        var result = [UIImage]()
        for i in 1...15 {
            var appendStr = i < 10 ?  "0\(i)":"\(i)"
            result.append(UIImage(named:"ac_pull_swing_\(appendStr)")!)
        }
        return result
    }()
    
    
    override func placeSubviews() {
        super.placeSubviews()
        //将gifView和stateLabel整体向右移动,使他们整体居中,所以横向移动距离为 
        //[mj_w - (gifWidth+textWidth+ self.labelLeftInset)]/2
        
        let textWidth:CGFloat = self.stateLabel.mj_textWith()
        let moveWidth = self.mj_w*0.5 - textWidth*0.5 - self.labelLeftInset*0.5 - self.gifView.mj_w*0.5
        
        var gifViewFrame: CGRect = self.gifView.frame
        gifViewFrame.origin.x = gifViewFrame.origin.x + moveWidth
        self.gifView.frame = gifViewFrame
        var labelFrame:CGRect = self.stateLabel.frame
        labelFrame.origin.x = labelFrame.origin.x + moveWidth
        self.stateLabel.frame = labelFrame
        
    }
    
    
}
