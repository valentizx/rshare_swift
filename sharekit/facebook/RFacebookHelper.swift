//
//  RFacebookHelper.swift
//  share
//
//  Created by valenti on 2018/7/19.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RFacebookHelper: NSObject {
    
    class func getLinkContent(webpageURL : String,
                              quote : String,
                              hashTag : String?) -> FBSDKShareLinkContent {
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: webpageURL)
        content.quote = quote
        
        
        guard hashTag != nil else {
            return content
        }
        content.hashtag = FBSDKHashtag(string: hashTag)
        return content
    }
    
    class func getPhotosContent(photos : Array<UIImage>) -> FBSDKSharePhotoContent {
        
        var sharePhotos : Array<FBSDKSharePhoto> = Array<FBSDKSharePhoto>()
        for p in photos {
            let photo = FBSDKSharePhoto(image: p, userGenerated: true)
            sharePhotos.append(photo!)
        }
        let content = FBSDKSharePhotoContent()
        content.photos = sharePhotos
        return content
        
    }
    class func getVideoContent(localVideoURL : URL) -> FBSDKShareVideoContent {
        let video = FBSDKShareVideo()
        video.videoURL = localVideoURL
        
        let content = FBSDKShareVideoContent()
        content.video = video
        return content
    }
    class func getMode(mode : ShareMode) -> FBSDKShareDialogMode {
        switch mode {
        case .Automatic:
            return .automatic
        case .Native:
            return .native
        case .Sheet:
            return .shareSheet
        case .Web:
            return .web
        case .Browser:
            return .browser
        case .Feed:
            return .feedWeb
        default:
            return .feedBrowser
        }
    }

    
    
}


