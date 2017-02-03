//
//  Contants.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/19.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation

struct Constants {
    
    static let PRIMARY_COLOR =  UIColor(colorLiteralRed: 253/255, green: 76/255, blue: 91/255, alpha: 1)
    
//    static var SCREEN_FRAME_WITHOUT_STATUSBAR:CGRect!
    
    static var SCREEN_FRAME:CGRect!  //(0.0, 0.0, 414.0, 736.0)

    static var STATUSBAR_FRAME:CGRect! //(0.0, 0.0, 414.0, 20.0)
    
    static var NAVIGATIONBAR_FRAME:CGRect!  //(0.0, 0.0, 414.0, 44.0)
    
    
    struct CellIdentifier {
        static let IndexCollectionViewCellArticleIndentifier = "IndexCollectionViewCellArticle"
        static let IndexCollectionCellBannerIndentifier = "IndexCollectionCellBanner"
        
        static let IndexCollectionCellMonkeyMountainHeadLineIndentifier = "IndexCollectionCellMonkeyMountainHeadLine"
    }
    
    struct HeaderIndentifier {
        static let IndexPageHeaderIndentifier = "IndexPageHeader"
        static let IndexSectionHeaderIndentifier = "IndexSectionHeader"
    }
    
    struct CollectionItemHeight {
        static let IndexPageScrollHeight:CGFloat = 150
        static let IndexCellArticleHeight:CGFloat = 100
        static let IndexCellBannerHeight:CGFloat = 100
        static let IndexSectionHeaderHeight: CGFloat = 35
        static let IndexCollectionCellMonkeyMountainHeadLineHeight:CGFloat = 140
    }
    
    //轮播图片
    //猴山头条(video n*2) + 全站排行榜(banner)
    //香蕉排行榜(video n*1) + 香蕉排行榜(banner)
    //番剧(video n*3) + 更多
    // TODO
    //
    //
    enum IndexCellType: Int {
        case carousels = 5 //轮播
        case videos = 1//视频 1
        case videos_banana_list = 12 //视频_香蕉榜 12
        case banners = 6 //横幅 6
        case bangumis = 3 //番剧 3
        case articles = 2//文章 2
    }
    
    

}
