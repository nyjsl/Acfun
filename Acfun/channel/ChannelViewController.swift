//
//  ChannelViewController.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/18.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import RxSwift
import LewReorderableLayout
class ChannelViewController: UIViewController {

    
    @IBOutlet weak var channelCollectionView: UICollectionView!
    
    var allChannel: [ChildChannel] = []{
        didSet{
            updateCollectionView()
        }
    }
    
    @IBOutlet weak var reorderLayout: LewReorderableLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgitaionBar()
        getChannels()
        setUpCollectionView()
    }
    
    private func setUpCollectionView(){
    
        registerReusables()
//        addLongPressReorderGesture()
        reorderLayout.delegate = self
        reorderLayout.dataSource = self
    }
    
    
//    private func addLongPressReorderGesture(){
//        self.channelCollectionView.addGestureRecognizer(longPressGestureRecognizer)
//    }
//    
//    
//    private lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
//        let gestureRec = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gestureRecoginer:)))
//        return gestureRec
//    }()
//    
//    @objc func longPress(gestureRecoginer: UIGestureRecognizer){
//        //获取手势在view种点击的坐标
//        let ponit:CGPoint = gestureRecoginer.location(in: self.channelCollectionView)
//        
//        switch gestureRecoginer.state {
//        case .began:
//            let indexPath = self.channelCollectionView.indexPathForItem(at: ponit)
//            self.channelCollectionView.beginInteractiveMovementForItem(at: indexPath!)
//        case .changed:
//            self.channelCollectionView.updateInteractiveMovementTargetPosition(ponit)
//        case .ended:
//            self.channelCollectionView.endInteractiveMovement()
//        default:
//            self.channelCollectionView.cancelInteractiveMovement()
//           
//        }
//    }
    
    fileprivate lazy var channelCellIdentifier: String = {
       return Constants.CellIdentifier.ChannelCollectionCellIndentifier
    }()
    
    fileprivate lazy var channelFooterIdentifier:String = {
        return Constants.FooterIndentifer.ChannelFooterIndentifier
    }()
    
    private func registerReusables(){
        let nibChannelCell = UINib(nibName: channelCellIdentifier, bundle: nil)
        self.channelCollectionView.register(nibChannelCell, forCellWithReuseIdentifier: Constants.CellIdentifier.ChannelCollectionCellIndentifier)
        
        let nibChannelFooter = UINib(nibName: channelFooterIdentifier, bundle: nil)
        self.channelCollectionView.register(nibChannelFooter, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: channelFooterIdentifier)
    }
    
    private func setupNavgitaionBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let channelNavBar = ChannelNavBar.generate(){
            self.navigationController?.view.addSubview(channelNavBar)
        }
        
    }
    
    private func updateCollectionView(){
        self.channelCollectionView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private func getChannels(){
        let observable:Observable<DataResponse<BaseChannel>> = RxProvider<APIAcfun>.requestObject(target: .channels)
        let _ = observable.subscribe(onNext: { [unowned self ](dataResponse) in
            if let channels = dataResponse.result.value?.data{
                self.allChannel = channels
            }
            
        }, onError: nil ,onCompleted: nil, onDisposed: nil)        //test channels
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ChannelViewController: LewReorderableLayoutDataSource,LewReorderableLayoutDelegate{
    
    
    
//    //实现Cell重排的代码
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        //移动数据
//        let dataToMove = self.allChannel[sourceIndexPath.item]
//        self.allChannel.remove(at: sourceIndexPath.item)
//        self.allChannel.insert(dataToMove, at: destinationIndexPath.item)
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allChannel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: channelCellIdentifier, for: indexPath)
        
        let channelCell = cell as! ChannelCollectionViewCell
        channelCell.channel = allChannel[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionFooter:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: channelFooterIdentifier, for: indexPath)
        default:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: channelFooterIdentifier, for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: Constants.SCREEN_FRAME.size.width, height: Constants.CollectionItemHeight.ChannelFooterHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //通过ChildChannel的个数计算Cell高度
        guard let count = allChannel[indexPath.row].childChannels?.count else{
            return CGSize(width: 0, height: 0)
        }
        let width = Constants.SCREEN_FRAME.size.width
        var rows = 1
        while rows*3 < count {
            rows = rows+1
        }
        return CGSize(width: width, height: Constants.CollectionItemHeight.ChannleChildellHeight.multiplied(by: CGFloat(rows)).advanced(by: Constants.CollectionItemHeight.ChannelChildTitleHeight).advanced(by: 10))
    }
    
//    //行间距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    //列间距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }

    
}
