//
//  Contants.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/19.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation

struct Constants {
    //红色
    static let PRIMARY_COLOR =  UIColor(colorLiteralRed: 253/255, green: 76/255, blue: 91/255, alpha: 1)
    //黄色
    static let PRIMARY_COLOR_BLUE = UIColor(colorLiteralRed: 254/255, green: 223/255, blue: 50/255, alpha: 1)

    
//    static var SCREEN_FRAME_WITHOUT_STATUSBAR:CGRect!
    
    static var SCREEN_FRAME:CGRect!  //(0.0, 0.0, 414.0, 736.0)

    static var STATUSBAR_FRAME:CGRect! //(0.0, 0.0, 414.0, 20.0)
    
    static var NAVIGATIONBAR_FRAME:CGRect!  //(0.0, 0.0, 414.0, 44.0)
    
    static var TAB_BAR_FRAM: CGRect! //(0.0, 687.0, 414.0, 49.0)
    
    struct CellIdentifier {
        static let IndexCollectionViewCellArticleIndentifier = "IndexCollectionViewCellArticle"
        static let IndexCollectionCellBannerIndentifier = "IndexCollectionCellBanner"
        
        static let IndexCollectionCellMonkeyMountainHeadLineIndentifier = "IndexCollectionCellMonkeyMountainHeadLine"
        
        static let IndexCollectionCellMonkeyMountainHeadLineRightIndentifier = "IndexCollectionCellMonkeyMountainHeadLineRight"
        
        static let IndexCollectionCellBananaRankIndentifier = "IndexCollectionCellBananaRank"
        
        static let IndexCollectionCellBagiumsIdentifer = "IndexCollectionCellBagiums"
        
        static let ChannelCollectionCellIndentifier = "ChannelCollectionViewCell"
        
        static let ChannelChildCollectionCellIndentifier = "ChildChannelCollectionViewCell"

    }
    
    struct HeaderIndentifier {
        static let IndexPageHeaderIndentifier = "IndexPageHeader"
        static let IndexSectionHeaderIndentifier = "IndexSectionHeader"
    }
    
    struct FooterIndentifer {
        static let IndexSectionMoreFooterIndentifier = "IndexSectionMoreFooter"
        static let ChannelFooterIndentifier = "ChannelCollectionFooterCollectionReusableView"
    }
    
    struct CollectionItemHeight {
        static let IndexPageScrollHeight:CGFloat = 150
        static let IndexCellArticleHeight:CGFloat = 100
        static let IndexCellBannerHeight:CGFloat = 110
        static let IndexSectionHeaderHeight: CGFloat = 40
        static let IndexCollectionCellMonkeyMountainHeadLineHeight:CGFloat = 150
        static let IndexSectionFooterHeight:CGFloat = 46
        static let IndexCellBananaRank:CGFloat = 100
        static let IndexCollectionCellBagiums:CGFloat = 220
        //频道的子CollectionViewCell的高度，父CollectionViewCell通过子Cell的个数计算
        static let ChannleChildellHeight: CGFloat = 35
        static let ChannelChildTitleHeight: CGFloat = 40
        static let ChannelFooterHeight: CGFloat = 50

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
