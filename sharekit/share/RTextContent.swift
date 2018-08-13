//
//  RTextContent.swift
//  share
//
//  Created by valenti on 2018/8/6.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

typealias RTextContentBuilderBlock = (_ builder : RTextContentBuilder) -> Void

class RTextContent: NSObject {
    fileprivate(set) var body : String?
    fileprivate(set) var title : String?
    fileprivate(set) var webpageURL : String?
    
    class func make(block : RTextContentBuilderBlock) -> RTextContent {
        
        let builder = RTextContentBuilder()
        block(builder)
        return builder.build()
    }

}

class RTextContentBuilder : NSObject {
    
    var body : String?
    var title : String?
    var webpageURL : String?
    
    func build() -> RTextContent {
        
        let content = RTextContent()
        content.body = body
        content.title = title
        content.webpageURL = webpageURL
        return content
    }
    
}
