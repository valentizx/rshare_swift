//
//  RPlatform.swift
//  sharekit
//
//  Created by valenti on 2018/7/17.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

enum RShareSDKPlatform {
    
    case Wechat
    case Facebook
    case Twitter
    case Sina
    case Instagram
    case QQ
    case Tumblr
    case WhatsApp
    case Line
    case Pinterest
    case GooglePlus
    case Other
}

typealias PlatformBuilderBlock = (_ builder : PlatformBuilder) -> Void

class RPlatform: NSObject {
    
    
    fileprivate(set) var targets : Array<RShare.Type> = []
    
    
    
    class func isInstalled(platform : RShareSDKPlatform) -> Bool {
    
        var appString = ""
        
        switch platform {
        case .Wechat:
            return WXApi.isWXAppInstalled()
        case .WhatsApp:
            appString = "whatsapp://"
        case .QQ:
            return QQApiInterface.isQQInstalled()
       
        case .Facebook:
            appString = "fbapi://"
        case .Twitter:
            appString = "twitter://"
        case .Sina:
            return WeiboSDK.isWeiboAppInstalled()
        case .Instagram:
            appString = "instagram://"
        case .Line:
            appString = "line://"
        case .Pinterest:
            appString = "pinterestsdk.v1://"
            
        case .Tumblr: fallthrough
        case .GooglePlus: fallthrough
            
        case .Other: break
            
        }
        return UIApplication.shared.canOpenURL(URL(string: appString)!)
        
    }
    
    class func make(block : PlatformBuilderBlock) -> RPlatform {
        
        let builder = PlatformBuilder()
        
        block(builder)
        
        return builder.build()
        
    }

}

class PlatformBuilder : NSObject{
    
    var targets : Array<RShare.Type> = []
    
    let infoDic : Dictionary<String , RShare.Type> = [
        "QQ" : RQqManager.self,
        "Line" : RLineManager.self,
        "Sina" : RSinaWeiboManager.self,
        "Tumblr" : RTumblrManager.self,
        "Facebook" : RFacebookManager.self,
        "Twitter" : RTwitterManager.self,
        "Wechat" : RWechatManager.self,
        "WhatsApp" : RWhatsAppManager.self,
        "Instagram" : RInstagramManager.self,
        "GooglePlus" : RGooglePlusManager.self,
        "Pinterest" : RPinterestManager.self
    ]
    
    func add(p : RShareSDKPlatform) {
        targets.append(infoDic["\(p)"]!)
    }
    func build() -> RPlatform {
        
        let p = RPlatform()
        
        p.targets = targets
        
        return p
    }
    
}
