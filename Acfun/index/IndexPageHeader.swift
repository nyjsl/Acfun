//
//  IndexPageHeader.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/24.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

import YYWebImage

class IndexPageHeader: UICollectionReusableView {

    @IBOutlet weak var pageScrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    fileprivate var pageNumber:Int = 0{
        didSet{
           updatePageControl()
           updateScrollView()
           loadImages()
        }
    }
    
    var contents:[Region.Content]? = []{
        didSet{
            pageNumber = contents?.count ?? 0
        }
    }
    
    var imageViewArray: [UIImageView] = []
    
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
        pageScrollView.contentSize = CGSize(width:contentWidth, height:Constants.CollectionItemHeight.IndexPageScrollHeight)
        updateScrollViewContents()
    }
    
    private func updateScrollViewContents(){
        imageViewArray.removeAll()
        for index in 0..<pageNumber{
            let originX = Constants.SCREEN_FRAME.size.width.multiplied(by: CGFloat(integerLiteral: index))
            let frame = CGRect(x: originX, y:0 , width: Constants.SCREEN_FRAME.size.width, height: Constants.CollectionItemHeight.IndexPageScrollHeight)
            let imageView = UIImageView(frame: frame)
            imageViewArray.append(imageView)
            pageScrollView.addSubview(imageView)
        }
    }
    
    func loadImages(){
        for i in 0..<imageViewArray.count{
            let img = imageViewArray[i]
            let url = URL(string: (contents?[i].image!)!)
            img.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"), options: .progressive, completion: nil)
            
        }
    }
    
}

extension IndexPageHeader: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let result = scrollView.contentOffset.x.divided(by: Constants.SCREEN_FRAME.size.width)
        pageControl.currentPage = Int(result)
    }
}


