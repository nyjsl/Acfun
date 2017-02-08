//
//  IndexViewController.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/18.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import RxSwift
//首页
class IndexViewController: UIViewController {

    
    @IBOutlet weak var indexCollectionView: UICollectionView!
    
    /*
     获取到的首页数据
     */
    var datas:[Region] = []{
        didSet{
            updateCollectionView()
        }
    }
    
    var diyHeader: IndexDIYHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIndexNavbar()
        initCollectionView()
        getDatas()
    }
    
    /*
     获取首页数据
     */
    private func getDatas(){
        
        let observable:Observable<DataResponse<BaseRegions>> = RxProvider<APIAcfun>.requestObject(target: .regions(id: nil))
        let _ = observable.subscribe(onNext: {[unowned self] (dataResponse) in
            if let datas = dataResponse.result.value?.data{
                self.datas = datas
                self.checkAndRequestForSingleRegion()
            }
        }, onError: nil ,onCompleted: {
            self.diyHeader?.endRefreshing()
        }, onDisposed: nil)
    }
    /*
     如果contentContent大于 实际的Content对象个数,则请求单个Region请求重新给Region列表中的 Region赋值
     */
    private func checkAndRequestForSingleRegion(){
        let len = self.datas.count
        
        for i in 0 ..< len{
            let region = self.datas[i]
            if needToRequestRegionById(region: region){
                let observable:Observable<DataResponse<BaseRegion>> =  RxProvider<APIAcfun>.requestObject(target: APIAcfun.regions(id: region.id))
                let _ = observable.subscribe(onNext: { (dataResponse) in
                    if let data = dataResponse.result.value?.data{
                        self.datas[i] = data
                    }
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            }
        }
        
    }
    /*
     判断是否需要请求单独的Region
     */
    private func needToRequestRegionById(region: Region) -> Bool{
        return  region.contentCount!>0 && (nil == region.children || region.children!.count<region.contentCount!)
    }
    
    //设置Index页的NavigationBar
    private func initIndexNavbar(){
        if let indexNavVC = self.navigationController{
            indexNavVC.setNavigationBarHidden(true, animated: false)
            if let indexNavBar =  IndexNavBar.generate(){
                indexNavBar.indexNavBarButtonDeleget = self
                indexNavVC.view.addSubview(indexNavBar)
            }
        }
    }
    
    private func initCollectionView(){
        
        indexCollectionView.delegate = self
        indexCollectionView.dataSource = self
        
        diyHeader = IndexDIYHeader(refreshingBlock: {
             self.getDatas()
        })
        indexCollectionView.mj_header = diyHeader
        registerHeaderAndCells()
    }
    //注册各种Cell 和 Header ,Footer
    private func registerHeaderAndCells(){
        let nibCellArticle = UINib(nibName:  Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier,
                        bundle: nil)
        indexCollectionView.register(nibCellArticle, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier)
        
        let nibPageControlHeader = UINib(nibName: Constants.HeaderIndentifier.IndexPageHeaderIndentifier, bundle: nil)
        indexCollectionView.register(nibPageControlHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.HeaderIndentifier.IndexPageHeaderIndentifier)
        
        let nibIndexSectionHeader = UINib(nibName: Constants.HeaderIndentifier.IndexSectionHeaderIndentifier, bundle: nil)
        indexCollectionView.register(nibIndexSectionHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.HeaderIndentifier.IndexSectionHeaderIndentifier)
        
        
        let nibCellBanner = UINib(nibName: Constants.CellIdentifier.IndexCollectionCellBannerIndentifier, bundle: nil)
        indexCollectionView.register(nibCellBanner, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellBannerIndentifier)
        
        let nibCellMonkeyMountainHeadLine = UINib(nibName: Constants.CellIdentifier.IndexCollectionCellMonkeyMountainHeadLineIndentifier, bundle: nil)
        indexCollectionView.register(nibCellMonkeyMountainHeadLine, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellMonkeyMountainHeadLineIndentifier)
        
        let nibCellMonkeyMountainHeadLineRight = UINib(nibName: Constants.CellIdentifier.IndexCollectionCellMonkeyMountainHeadLineRightIndentifier, bundle: nil)
        indexCollectionView.register(nibCellMonkeyMountainHeadLineRight, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellMonkeyMountainHeadLineRightIndentifier)
        
        let nibIndexSectionFooter = UINib(nibName: Constants.FooterIndentifer.IndexSectionMoreFooterIndentifier, bundle: nil)
        
        indexCollectionView.register(nibIndexSectionFooter, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: Constants.FooterIndentifer.IndexSectionMoreFooterIndentifier)
        
        let nibIndexBananaRankCell = UINib(nibName: Constants.CellIdentifier.IndexCollectionCellBananaRankIndentifier, bundle: nil)
        indexCollectionView.register(nibIndexBananaRankCell, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellBananaRankIndentifier)
        
        let nibCellBangiums = UINib(nibName: Constants.CellIdentifier.IndexCollectionCellBagiumsIdentifer, bundle: nil)
        indexCollectionView.register(nibCellBangiums, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellBagiumsIdentifer)
    }
    
    private func updateCollectionView(){
        indexCollectionView.reloadData()
    }
    
        
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }


}

extension IndexViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let region = datas[section]
        
        switch region.type!.id! {
        case Constants.IndexCellType.carousels.rawValue: //轮播
            return 0
        default:
            return region.contentCount!
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let region = datas[indexPath.section]
        var cell: UICollectionViewCell
        cell = getInitCellsByType(region, indexPath)
        return cell
    }
    /*
     生成各种Cell
     */
    private func getInitCellsByType(_ region: Region,_ indexPath: IndexPath) -> UICollectionViewCell{
        var cell: UICollectionViewCell
       
        
        switch region.type!.id! {
        case Constants.IndexCellType.carousels.rawValue:
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, for: indexPath)
        case Constants.IndexCellType.banners.rawValue:
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellBannerIndentifier, for: indexPath)
            let bannerCell = cell as! IndexCollectionCellBanner
            bannerCell.bannerRegion = region
        case Constants.IndexCellType.videos.rawValue:
            
            
            if indexPath.row % 2 == 0 {
                cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellMonkeyMountainHeadLineIndentifier, for: indexPath)
                let monkeyMountainHeadLlineCell = cell as! IndexCollectionCellMonkeyMountainHeadLine
                monkeyMountainHeadLlineCell.monkeyMountainHeadlinContent = region.contents?[indexPath.row]
            }else{
                cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellMonkeyMountainHeadLineRightIndentifier, for: indexPath)
                let monkeyMountainHeadLlineCell = cell as! IndexCollectionCellMonkeyMountainHeadLineRight
                monkeyMountainHeadLlineCell.monkeyMountainHeadlinContent = region.contents?[indexPath.row]
            }
            
        case Constants.IndexCellType.videos_banana_list.rawValue:
            
            
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellBananaRankIndentifier, for: indexPath)
            
            let bananaRankCell = cell as! IndexCollectionCellBananaRank
            
            bananaRankCell.content = region.contents?[indexPath.row]
            bananaRankCell.rankNo = indexPath.row
        
        case Constants.IndexCellType.bangumis.rawValue:
            
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellBagiumsIdentifer, for: indexPath)
            
            let bangumiCell = cell as! IndexCollectionCellBagiums
            bangumiCell.content = region.contents?[indexPath.row]
            
        case Constants.IndexCellType.articles.rawValue:
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, for: indexPath)
            let articleCell = cell as! IndexCollectionViewCellArticle
            articleCell.row = indexPath.row
            articleCell.content = region.contents?[indexPath.row]
            
        default:
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, for: indexPath)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let region = datas[indexPath.section]
        return getCellSizeByType(region, indexPath)
        
    }
    
    /*
     返回各cell的CGSize
     */
    private func getCellSizeByType(_ region: Region,_ indexPath: IndexPath) -> CGSize{
        switch region.type!.id! {
        
        case Constants.IndexCellType.banners.rawValue:
           return CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.CollectionItemHeight.IndexCellBannerHeight)
        case Constants.IndexCellType.videos.rawValue:
            return CGSize(width: Constants.SCREEN_FRAME.width.advanced(by: -10).divided(by: 2), height: Constants.CollectionItemHeight.IndexCollectionCellMonkeyMountainHeadLineHeight)
        case Constants.IndexCellType.videos_banana_list.rawValue:
            return CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.CollectionItemHeight.IndexCellBananaRank)
        case Constants.IndexCellType.bangumis.rawValue:
            return CGSize(width: Constants.SCREEN_FRAME.width.advanced(by: -20).divided(by: 3), height: Constants.CollectionItemHeight.IndexCollectionCellBagiums)
        default:
            return CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.CollectionItemHeight.IndexCellBannerHeight)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var resuableView: UICollectionReusableView
        let region = datas[indexPath.section]

        switch kind {
        case UICollectionElementKindSectionHeader:
            
            switch region.type!.id! {
            case Constants.IndexCellType.carousels.rawValue:
                resuableView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.HeaderIndentifier.IndexPageHeaderIndentifier, for: indexPath)
                let header = resuableView as! IndexPageHeader
                
                header.contents = region.contents
            case Constants.IndexCellType.banners.rawValue:
                resuableView = UICollectionReusableView()
            default:
               resuableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.HeaderIndentifier.IndexSectionHeaderIndentifier, for: indexPath)
                let header = resuableView as! IndexSectionHeader
                header.iconImageUrl = region.image
                header.titleText = region.name
            }
        case UICollectionElementKindSectionFooter:
            if region.showMore == 1{
                resuableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.FooterIndentifer.IndexSectionMoreFooterIndentifier, for: indexPath)
                let footer = resuableView as! IndexSectionMoreFooter
                footer.title = region.name
                let isHidden = indexPath.section == datas.count-1
                footer.setLineViewIsHidden(isHidden: isHidden)
            }else{
               resuableView = UICollectionReusableView()
            }

        default:
            resuableView = UICollectionReusableView()
        }
        return resuableView
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let region = datas[section]
        
        switch region.type!.id! {
        case Constants.IndexCellType.carousels.rawValue: //轮播
            return  CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.CollectionItemHeight.IndexPageScrollHeight)
        case Constants.IndexCellType.banners.rawValue:
            return CGSize(width: 0, height: 0)
        default:
            return CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.CollectionItemHeight.IndexSectionHeaderHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let region = datas[section]
        if region.showMore == 1{
            return CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.CollectionItemHeight.IndexSectionFooterHeight)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    
    
}



extension IndexViewController:IndexNavBarButtonsDelegate{
    func gameCenterAction() {
        print("gameCenterAction")
    }
    
    func historyAction() {
        print("historyAction")
    }
    
    func searchAction() {
        print("searchAction")
    }
    
    func downloadAction() {
        print("downloadAction")
    }
}
