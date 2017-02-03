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
        let _ = observable.subscribe(onNext: { (dataResponse) in
            if let datas = dataResponse.result.value?.data{
                self.datas = datas
                //TOOD
            }
        }, onError: nil ,onCompleted: {
            self.diyHeader?.endRefreshing()
        }, onDisposed: nil)        //test channels
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
    //注册各种Cell 和 Header
    private func registerHeaderAndCells(){
        let nibCellArticle = UINib(nibName:  Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier,
                        bundle: nil)
        indexCollectionView.register(nibCellArticle, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier)
        let nibPageControlHeader = UINib(nibName: Constants.HeaderIndentifier.IndexPageHeaderIndentifier, bundle: nil)
        indexCollectionView.register(nibPageControlHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.HeaderIndentifier.IndexPageHeaderIndentifier)
        
        let nibCellBanner = UINib(nibName: Constants.CellIdentifier.IndexCollectionCellBannerIndentifier, bundle: nil)
        indexCollectionView.register(nibCellBanner, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellBannerIndentifier)
        
        let nibCellMonkeyMountainHeadLine = UINib(nibName: Constants.CellIdentifier.IndexCollectionCellMonkeyMountainHeadLineIndentifier, bundle: nil)
        indexCollectionView.register(nibCellMonkeyMountainHeadLine, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellMonkeyMountainHeadLineIndentifier)
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
            print(region.contentCount!)
            return region.contentCount!
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("row:\(indexPath.row) count:\(indexPath.count) section\(indexPath.section)")
        let region = datas[indexPath.section]
        var cell: UICollectionViewCell
        cell = getInitCellsByType(region, indexPath)
        return cell
    }
    //生成各种Cell
    private func getInitCellsByType(_ region: Region,_ indexPath: IndexPath) -> UICollectionViewCell{
        var cell: UICollectionViewCell
       
        
        switch region.type!.id! {
        case Constants.IndexCellType.carousels.rawValue:
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, for: indexPath)
        case Constants.IndexCellType.banners.rawValue:
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionCellBannerIndentifier, for: indexPath)
            let bannerCell = cell as! IndexCollectionCellBanner
            bannerCell.bannerRegion = region
        default:
            cell = self.indexCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, for: indexPath)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let region = datas[indexPath.section]
        return getCellSizeByType(region, indexPath)
        
    }
    
    private func getCellSizeByType(_ region: Region,_ indexPath: IndexPath) -> CGSize{
        switch region.type!.id! {
        
        case Constants.IndexCellType.banners.rawValue:
           return CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.CollectionItemHeight.IndexCellBannerHeight)
        case Constants.IndexCellType.videos.rawValue:
            return CGSize(width: Constants.SCREEN_FRAME.width.advanced(by: -20).divided(by: 2), height: Constants.CollectionItemHeight.IndexCollectionCellMonkeyMountainHeadLineHeight)
        default:
            return CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.CollectionItemHeight.IndexCellBannerHeight)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        var resuableView: UICollectionReusableView
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            let region = datas[indexPath.row]
            switch region.type!.id! {
            case Constants.IndexCellType.carousels.rawValue:
                resuableView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.HeaderIndentifier.IndexPageHeaderIndentifier, for: indexPath)
                let header = resuableView as! IndexPageHeader
                
                header.contents = region.contents
            default:
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
        default:
            return  CGSize(width: 0,height: 0)
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
