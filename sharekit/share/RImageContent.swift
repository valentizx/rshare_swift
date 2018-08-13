//
//  RImageContent.swift
//  share
//
//  Created by valenti on 2018/8/6.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit


typealias ImageContentBuilderBlock = (_ builder : RImageContentBuilder) -> Void

class RImageContent: NSObject {
    
    fileprivate(set) var image : UIImage?
    fileprivate(set) var title : String?
    fileprivate(set) var quote : String?
    fileprivate(set) var imageURL : String?
    fileprivate(set) var webpageURL : String?
    
    class func make(block : ImageContentBuilderBlock) -> RImageContent {
        let builder = RImageContentBuilder()
        block(builder)
        return builder.build()
    }
}


class RImageContentBuilder : NSObject {
    
    var image : UIImage?
    var title : String?
    var quote : String?
    var imageURL : String?
    var webpageURL : String?
    
    func build() -> RImageContent {
        
        let content = RImageContent()
        content.image = image
        content.title = title
        content.quote = quote
        content.imageURL = imageURL
        content.webpageURL = webpageURL

        return content
    }
    
}
