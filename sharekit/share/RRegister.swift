//
//  RRegister.swift
//  share
//
//  Created by valenti on 2018/8/3.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RRegister: NSObject {
    
    static let shared = RRegister()
    private override init() {}
    
    func connectFacebook(appID : String, secret : String?) {
        RFacebookManager.shared.sdkInitialize(appID: appID, secret: secret)
    }
    
    func connectSinaWeibo(appKey : String, secret : String) {
        RSinaWeiboManager.shared.sdkInitialize(appKey: appKey, appSecret: secret)
    }
    func connectTwitter(consumerKey : String, secret : String) {
        RTwitterManager.shared.sdkInitialize(consumerKey: consumerKey, consumerSecret: secret)
    }
    func connectTumblr(consumerKey : String, secret : String) {
        RTumblrManager.shared.sdkInitialize(consumerKey: consumerKey, consumerSecret: secret)
    }
    func connectPinterest(appID : String, secret : String?) {
        RPinterestManager.shared.sdkInitialize(appID: appID, appSecret: secret)
    }
    func connectQQ(appID : String, key : String) {
        RQqManager.shared.sdkInitialize(appID: appID, appKey: key)
        
    }
    func connectWechat(appID : String, secret : String) {
        RWechatManager.shared.sdkInitialize(appID: appID, appSecret: secret)
        
    }

}
