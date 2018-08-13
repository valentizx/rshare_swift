//
//  RVideoContent.swift
//  share
//
//  Created by valenti on 2018/8/6.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit


typealias RVideoContentBuilderBlock = (_ builder : RVideoContentBuilder) -> Void

class RVideoContent: NSObject {
    
    fileprivate(set) var videoAssetURL : URL?
    fileprivate(set) var videoFileURL : URL?
    fileprivate(set) var videoWebapgeURL : URL?
    fileprivate(set) var title : String?
    fileprivate(set) var quote : String?
    fileprivate(set) var thumbImage : UIImage?
    
    class func make(block : RVideoContentBuilderBlock) -> RVideoContent {
        let builder = RVideoContentBuilder()
        block(builder)
        return builder.build()
    }

}

class RVideoContentBuilder : NSObject {
    
    var videoAssetURL : URL?
    var videoFileURL : URL?
    var videoWebapgeURL : URL?
    var title : String?
    var quote : String?
    var thumbImage : UIImage?
    
    func build() -> RVideoContent {
        
        let content = RVideoContent()
        content.videoAssetURL = videoAssetURL
        content.videoFileURL = videoFileURL
        content.videoWebapgeURL = videoWebapgeURL
        content.title = title
        content.quote = quote
        content.thumbImage = thumbImage
        
        return content
    }
}
