//
//  RWebpageContent.swift
//  share
//
//  Created by valenti on 2018/8/6.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

typealias RWebpageContentBuilderBlock = (_ builder : RWebpageContentBuilder) -> Void

class RWebpageContent: NSObject {
    
    fileprivate(set) var webpageURL : String?
    fileprivate(set) var title : String?
    fileprivate(set) var quote : String?
    fileprivate(set) var hashTag : String?
    fileprivate(set) var thumbImage : UIImage?
    
    class func make(block : RWebpageContentBuilderBlock) -> RWebpageContent{
        let builder = RWebpageContentBuilder()
        block(builder)
        return builder.build()
    }

}

class RWebpageContentBuilder : NSObject {
    
    var webpageURL : String?
    var title : String?
    var quote : String?
    var hashTag : String?
    var thumbImage : UIImage?
    
    func build() -> RWebpageContent {
        
        let content = RWebpageContent()
        content.webpageURL = webpageURL
        content.hashTag = hashTag
        content.quote = quote
        content.thumbImage = thumbImage
        
        return content
    }
    
}
