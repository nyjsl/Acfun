//
//  IndexPageHeader.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/24.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

class IndexPageHeader: UICollectionReusableView {

    @IBOutlet weak var pageScrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageNumber:Int = 4{
        didSet{
           updatePageControl()
           updateScrollView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        preparePageControl()
        prepareScrollView()
    }
    
    private func preparePageControl(){
        pageControl.setValue(#imageLiteral(resourceName: "page_contrl_point"), forKey: "pageImage")
        pageControl.setValue(#imageLiteral(resourceName: "page_contrl_current_point"), forKey: "currentPageImage")
        pageControl.currentPage = 0
        updatePageControl()
    }
    
    private func prepareScrollView(){
        pageScrollView.isPagingEnabled = true
        pageScrollView.delegate = self
        pageScrollView.showsHorizontalScrollIndicator = false
        pageScrollView.showsVerticalScrollIndicator = false
        updateScrollView()
    }
    
    private func updatePageControl(){
        pageControl.numberOfPages = pageNumber
    }
    
    private func updateScrollView(){
        let contentWidth = Constants.SCREEN_FRAME.size.width * CGFloat(integerLiteral: pageNumber)
        pageScrollView.contentSize = CGSize(width:contentWidth, height:Constants.IndexPageScrollHeight)
    }
    
}

extension IndexPageHeader: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let result = scrollView.contentOffset.x.divided(by: Constants.SCREEN_FRAME.size.width)
        pageControl.currentPage = Int(result)
    }
}


