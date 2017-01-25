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
        
        let observable:Observable<DataResponse<BaseRegion>> = RxProvider<APIAcfun>.requestObject(target: .regions)
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
        let nib = UINib(nibName:  Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, bundle: nil)
        indexCollectionView.register(nib, forCellWithReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier)
        indexCollectionView.delegate = self
        indexCollectionView.dataSource = self
        
       
        diyHeader = IndexDIYHeader(refreshingBlock: {
             self.getDatas()
        })
        indexCollectionView.mj_header = diyHeader
        
        let nibPageControlHeader = UINib(nibName: Constants.HeaderIndentifier.IndexPageHeaderIndentifier, bundle: nil)
        indexCollectionView.register(nibPageControlHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.HeaderIndentifier.IndexPageHeaderIndentifier)

        
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
        
        var cell: UICollectionViewCell
        let region = datas[indexPath.row]
        
        switch region.type!.id! {
        case Constants.IndexCellType.carousels.rawValue:
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, for: indexPath)
            
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.SCREEN_FRAME.width, height: 100)
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
            return  CGSize(width: Constants.SCREEN_FRAME.width, height: Constants.IndexPageScrollHeight)
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
