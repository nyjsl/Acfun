//
//  IndexPageHeader.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/24.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit

import YYWebImage
/**
 _________  ________  _______
 |        | |       | |      |
 |________| |_______| |______|
 
 */

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
    
    var pageNumberForInfinite:Int = 0
    
    var contents:[Region.Content]? = []{
        didSet{
            pageNumber = contents?.count ?? 0
            
            pageNumberForInfinite = pageNumber+2
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
    
    var timer: Timer?
    
    fileprivate func addTimer(){
        timer = Timer(timeInterval: 2, repeats: true, block: { [weak self ](timer) in
            self?.nextImage()
        })
        
        guard let timer = timer else{
            return
        }
        
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    fileprivate func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    private func nextImage(){
        let currentPage = pageControl.currentPage
        if currentPage == pageNumber-1{
            pageControl.currentPage = 0
        }else{
            pageControl.currentPage = currentPage+1
        }
        let offSetX = Constants.SCREEN_FRAME.size.width.multiplied(by: CGFloat(pageControl.currentPage+1))
        self.pageScrollView.setContentOffset(CGPoint(x:offSetX, y: 0), animated: true)
    }
    
    private func updatePageControl(){
        pageControl.numberOfPages = pageNumber
    }
    
    private func updateScrollView(){
        let contentWidth = Constants.SCREEN_FRAME.size.width.multiplied(by: CGFloat(pageNumberForInfinite))
        pageScrollView.contentSize = CGSize(width:contentWidth, height:Constants.CollectionItemHeight.IndexPageScrollHeight)
        updateScrollViewContents()
    }
    
    private func updateScrollViewContents(){
        imageViewArray.removeAll()
        for index in 0..<pageNumberForInfinite{
            let originX = Constants.SCREEN_FRAME.size.width.multiplied(by: CGFloat(index))
            let frame = CGRect(x: originX, y:0 , width: Constants.SCREEN_FRAME.size.width, height: Constants.CollectionItemHeight.IndexPageScrollHeight)
            let imageView = UIImageView(frame: frame)
            imageView.contentMode = .scaleAspectFill
            imageViewArray.append(imageView)
            pageScrollView.addSubview(imageView)
        }
        //显示第1个
        pageScrollView.setContentOffset(CGPoint(x:Constants.SCREEN_FRAME.size.width,y:0), animated: false)
        removeTimer()
        addTimer()
    }
    
    func loadImages(){
        for i in 0..<imageViewArray.count{
            let img = imageViewArray[i]
            var url: URL!
            if i == 0{
                url = URL(string: (contents?[pageNumber-1].image!)!)
            }else if i == imageViewArray.count-1{
                url = URL(string: (contents?[0].image!)!)
            }else{
               url = URL(string: (contents?[i-1].image!)!)
            }
            
            img.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"), options: .progressive, completion: nil)
            
        }
    }
    
}

extension IndexPageHeader: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let result = Int(scrollView.contentOffset.x.divided(by: Constants.SCREEN_FRAME.size.width))
        if result == 0{
            pageControl.currentPage = pageNumber - 1

        }else if result == pageNumberForInfinite - 1{
            pageControl.currentPage = 0
        }else{
            pageControl.currentPage = result - 1
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         removeTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let result = Int(scrollView.contentOffset.x.divided(by: Constants.SCREEN_FRAME.size.width))
        var offSetx = 0
        if result == 0{
            offSetx = Int(Constants.SCREEN_FRAME.size.width.multiplied(by: CGFloat(pageNumberForInfinite.advanced(by: -2))))
            scrollView.setContentOffset(CGPoint(x:offSetx,y:0), animated: false)
        }else if result == pageNumberForInfinite.advanced(by: -1){
            scrollView.setContentOffset(CGPoint(x:Constants.SCREEN_FRAME.size.width,y:0), animated: false)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
   
}


