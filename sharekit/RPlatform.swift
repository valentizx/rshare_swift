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
    case Other
}

class RPlatform: NSObject {
    
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
        case .Tumblr: break
            
        case .Other: break
        }
        return UIApplication.shared.canOpenURL(URL(string: appString)!)
        
    }

}
