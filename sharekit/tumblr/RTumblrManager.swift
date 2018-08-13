//
//  RTumblrManager.swift
//  share
//
//  Created by valenti on 2018/7/20.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit
import Flurry_iOS_SDK

class RTumblrManager: RShare {
    
    static let  shared = RTumblrManager()
    private override init() {}
    
    fileprivate var shareCompletion : RShareCompletion?
    
    func sdkInitialize(consumerKey : String, consumerSecret : String) {
        FlurryTumblr.setConsumerKey(consumerKey, consumerSecret: consumerSecret)
        FlurryTumblr.setDelegate(self)
    
    }
    override class func connect(c: (RShareSDKPlatform, RRegister) -> Void) {
        c(.Tumblr, RRegister.shared)
    }
    
    
    func share(imageURL : String,
               description : String,
               webpageURL : String,
               from : UIViewController,
               completion : RShareCompletion?) {
        shareCompletion = completion
        let param = FlurryImageShareParameters()
        param.imageURL = imageURL
        param.imageCaption = description
        param.webLink = webpageURL
        FlurryTumblr.post(param, presenting: from)
    }
    
    func share(text: String,
               title : String,
               webpageURL : String,
               from : UIViewController,
               completion : RShareCompletion?) {
        shareCompletion = completion
        let param = FlurryTextShareParameters()
        param.title = title
        param.text = text
        FlurryTumblr.post(param, presenting: from)
    }
    
    
    deinit {
        FlurryTumblr.setDelegate(nil)
    }

}
extension RTumblrManager : FlurryTumblrDelegate {
    func flurryTumblrPostSuccess() {
        guard shareCompletion != nil else {
            return
        }
        shareCompletion!(.Tumblr, .Success, nil)
    }
    func flurryTumblrPostError(_ error: Error!, errorType: FlurryTumblrErrorType) {
        guard shareCompletion != nil else {
            return
        }
        if errorType == FlurryTumblrUserCanceled {
            shareCompletion!(.Tumblr, .Cancel, nil)
        } else {
            shareCompletion!(.Tumblr, .Failure, error.localizedDescription)
        }
    }
}
