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
        // Override point for customization after application launch.
        let _ = RFacebookManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // return RWechatManager.shared.application(app, open: url, options : options)
        // return RSinaWeiboManager.shared.application(app, open: url, options : options)
        // return RQqManager.shared.application(app, open: url, options : options)
        // return RFacebookManager.shared.application(app, open: url, options : options)
        return RPinterestManager.shared.application(app, open: url, options : options)
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // return RWechatManager.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        // return RSinaWeiboManager.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        // return RQqManager.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        return RFacebookManager.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

}

