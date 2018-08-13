//
//  AppDelegate.swift
//  share
//
//  Created by valenti on 2018/6/27.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let string = "wwww.google.com"
        
        print(string.split(separator: "."))
        
        let _ = RFacebookManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        let platform = RPlatform.make { (builder) in
            builder.add(p: .Facebook)
            builder.add(p: .Twitter)
            builder.add(p: .QQ)
            builder.add(p: .Wechat)
            builder.add(p: .Instagram)
            builder.add(p: .Tumblr)
            builder.add(p: .Pinterest)
            builder.add(p: .Sina)
            builder.add(p: .GooglePlus)
            builder.add(p: .Line)
            builder.add(p: .WhatsApp)
            
        }
        
        
        print("❤️❤️❤️❤️❤️\(platform.targets.count)")
        
        RShareManager.shared.registerPlatform(platform: platform) { (p, obj) in
            switch p {
            case .Facebook:
                obj.connectFacebook(appID: "234270717151331", secret: nil)
            case .Pinterest:
                obj.connectPinterest(appID: "4979706154532747851", secret: nil)
            case .QQ:
                obj.connectQQ(appID: "1106463933", key: "4WSrOXMoeFMDNR2k")
            case .Sina:
                obj.connectSinaWeibo(appKey: "3026908911", secret: "91fbafc7be7510c0ac5d73883c655db1")
            case .Wechat:
                obj.connectWechat(appID: "wxd471bcf3a21c7c4a", secret: "f71570ef272a5a6699decb264be9cdbb")
            case .Tumblr:
                obj.connectTumblr(consumerKey: "ZJIv7SNrKMcct5tdQy7rzzsv3b0pTxBNYWkV548LgbIDIwsnPt", secret: "7jsraXodsVSeMHMLtHg5FYyporapRTf2ahJFK2tsnV4x0fYjse")
            case .Twitter:
                obj.connectTwitter(consumerKey: "cA72pVIFxOOWWfT8t9sFLcNUS", secret: "Rc9ornOaSWTFYqFzxDIEtIcsaWoxRcVGJs6U71kAjhHcGHyEZi")
            default : break
            }
        }
        
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // return RWechatManager.shared.application(app, open: url, options : options)
        // return RSinaWeiboManager.shared.application(app, open: url, options : options)
        // return RQqManager.shared.application(app, open: url, options : options)
        // return RFacebookManager.shared.application(app, open: url, options : options)
        return RShareManager.shared.application(app, open: url, options : options)
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // return RWechatManager.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        // return RSinaWeiboManager.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        // return RQqManager.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        return RShareManager.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        RShareManager.shared.applicationDidBecomeActive(application)
    }

}

