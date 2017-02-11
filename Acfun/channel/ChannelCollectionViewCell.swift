//
//  ChannelCollectionViewCell.swift
//  Acfun
//
//  Created by 魏星 on 2017/2/11.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage

class ChannelCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var channelImgView: UIImageView!
    
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var childCollectionView: UICollectionView!
    
    @IBOutlet weak var plusLabel: UILabel!
    
    
    var channel: ChildChannel?{
        didSet{
            if let c = channel{
                childChannels = c.childChannels
                if let name = c.name{
                    channelNameLabel.text = name
                }
                if let iconUrl = c.img{
                    loadIconByUrl(iconUrl)
                }
            }
        }
    }
    
    private func loadIconByUrl(_ iconUrl:String){
        let url = URL(string: iconUrl)
        channelImgView.yy_setImage(with: url, placeholder: nil)
    }
    
    fileprivate var childChannels: [ChildChannel]?{
        didSet{
            if let _ = childChannels{
               updateCollectionView()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        
        plusLabel.isHidden = true
    }
    
    fileprivate lazy var indentifier: String = {
        return Constants.CellIdentifier.ChannelChildCollectionCellIndentifier
    }()
    
    
    private func setUpCollectionView(){
        childCollectionView.delegate = self
        childCollectionView.dataSource = self
        childCollectionView.isScrollEnabled = false
        let nibChildCell = UINib(nibName: indentifier, bundle: nil)
        self.childCollectionView.register(nibChildCell, forCellWithReuseIdentifier: indentifier)
    }
    
    private func updateCollectionView(){
        self.childCollectionView.reloadData()
    }
    
}

extension ChannelCollectionViewCell: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let c = childChannels else{
            return 0
        }
        return c.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath)
        
        let childCell = cell as! ChildChannelCollectionViewCell
        if let channels = self.childChannels{
            childCell.childChannel = channels[indexPath.row]
            childCell.row = indexPath.row
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.SCREEN_FRAME.size.width.divided(by: 3)
        return CGSize(width: width, height: Constants.CollectionItemHeight.ChannleChildellHeight)
    }
    
    //行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
        
    
}

