//
//  IndexViewController.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/18.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
//首页
class IndexViewController: UIViewController {

    
    @IBOutlet weak var indexCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIndexNavbar()
        
        initCollectionView()

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
        
        indexCollectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            print("refreshingBlock")
        })
        
        let diyHeader = IndexDIYHeader(refreshingBlock: {
            print("refreshingBlock")
        })
        indexCollectionView.mj_header = diyHeader
        
        let nibPageControlHeader = UINib(nibName: Constants.HeaderIndentifier.IndexPageHeaderIndentifier, bundle: nil)
        indexCollectionView.register(nibPageControlHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.HeaderIndentifier.IndexPageHeaderIndentifier)
        
        
    }
    
        
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }


}

extension IndexViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.IndexCollectionViewCellArticleIndentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.SCREEN_FRAME.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let resuableView: UICollectionReusableView
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            resuableView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.HeaderIndentifier.IndexPageHeaderIndentifier, for: indexPath)
        default:
            resuableView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.HeaderIndentifier.IndexPageHeaderIndentifier, for: indexPath)
        }
        return resuableView
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize(width: Constants.SCREEN_FRAME.width, height: 110)
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
