//
//  BaseRegion.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/5.
//  Copyright © 2017年 wx. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseRegions: BaseDatasModel<Region>{
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    }
}


class BaseRegion: BaseDataModel<Region>{
    override func mapping(map: Map) {
        super.mapping(map: map)
    }
}

struct Region: Mappable{
    
    var belong: Int?
    var channelId: Int?
    var children: [ChildChannel]? //TODO 这里的children对象不知道是什么
    var contentCount: Int?
    var contents: [Content]?
    var deviceType: Int?
    var goText: String?
    var hide: Int?
    var id: Int?
    var image: String?
    var menuCount:Int?
    var name: String?
    var pid: Int?
    var platformId: Int?
    var showLine: Int?
    var showMore:Int?
    var showName: Int?
    var sort: Int?
    var type: CType?
    var updateAt: String?
    var url: String?
    
    init?(map: Map) {
        //DO NOTHING
    }
    
    mutating func mapping(map: Map) {
        belong <- map["belong"]
        channelId <- map["channelId"]
        children <- map["children"]
        contentCount <- map["contentCount"]
        contents <- map["contents"]
        deviceType <- map["deviceType"]
        goText <- map["goText"]
        hide <- map["hide"]
        id <- map["id"]
        image <- map["image"]
        menuCount <- map["menuCount"]
        name <- map["name"]
        pid <- map["pid"]
        platformId <- map["platformId"]
        showLine <- map["showLine"]
        showMore <- map["showMore"]
        showName <- map["showName"]
        sort <- map["sort"]
        type <- map["type"]
        updateAt <- map["updateAt"]
        url <- map["url"]
        
    }
    
    struct Content: Mappable{
        
        var actionId: Int?
        var device: Int?
        var hide: Int?
        var id: Int?
        var image: String?
        var intro: String?
        var regionId: Int?
        var releaseAt: String?
        var shareTagShow:Int?
        var subTitle: String?
        var title: String?
        var updateAt: String?
        var url: String?
        var visit: Visit?
        var webImage: String?
        var webUrl: String?
        init?(map: Map) {
            //DONOTHING
        }
        
        mutating func mapping(map: Map) {
            actionId <- map["actionId"]
            device <- map["device"]
            hide <- map["hide"]
            id <- map["id"]
            image <- map["image"]
            intro <- map["intro"]
            regionId <- map["regionId"]
            releaseAt <- map["releaseAt"]
            shareTagShow <- map["shareTagShow"]
            subTitle <- map["subTitle"]
            title <- map["title"]
            updateAt <- map["updateAt"]
            url <- map["url"]
            visit <- map["visit"]
            webImage <- map["webImage"]
            webUrl <- map["webUrl"]
        }
        
        struct Visit: Mappable {
            var comments: Int?
            var danmakuSize: Int?
            var goldBanana: Int?
            var score: Int?
            var stows: Int?
            var ups: Int?
            var views: Int?
            
            init?(map: Map) {
                //DO NOTHING
            }
            
            mutating func mapping(map: Map) {
                comments <- map["comments"]
                danmakuSize <- map["danmakuSize"]
                goldBanana <- map["goldBanana"]
                score <- map["score"]
                stows <- map["stows"]
                ups <- map["ups"]
                views <- map["views"]
            }
        }
    }
    
    struct CType:Mappable {
        var id: Int?
        var name: String?
        var value: String?
        
        init?(map: Map) {
            //DO NOTHING
        }
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            name <- map["name"]
            value <- map["value"]
        }
    }
}

