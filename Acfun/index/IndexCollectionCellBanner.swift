//
//  IndexCollectionCellBanner.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/26.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
import YYWebImage
import RxSwift

//横幅Cell
class IndexCollectionCellBanner: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var bannerRegion: Region?{
        didSet{
            loadImage()
        }
    }
    
    private func loadImage(){
        if let imageUrl = getImagUrl(){
            bannerImage.yy_setImage(with: imageUrl, placeholder: #imageLiteral(resourceName: "image_view_default"))
        }else{
            requestImageUrlByIdAndLoad()
        }
    }
    
    
    private func getImagUrl() -> URL?{

        if let contents = bannerRegion?.contents{
            if contents.count>0{
                return URL(string: contents[0].image!)
            }
        }
        return nil
    }
    
    private func requestImageUrlByIdAndLoad(){
        let observable: Observable<DataResponse<BaseRegion>>= RxProvider<APIAcfun>.requestObject(target: APIAcfun.regions(id: bannerRegion?.id))
        let _ = observable.subscribe( onNext: {[unowned self] (dataResponse)  in
            if let data = dataResponse.result.value?.data{
                if let contents = data.contents{
                    if contents.count>0{
                        let url =  URL(string: contents[0].image!)
                        self.bannerImage.yy_setImage(with: url, placeholder: #imageLiteral(resourceName: "image_view_default"))
                    }
                }
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    

}
