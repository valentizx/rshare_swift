//
//  RFacebookManager.swift
//  share
//
//  Created by valenti on 2018/7/19.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RFacebookManager: RShare {
    
    static let shared = RFacebookManager()
    private override init() {}
    
    fileprivate var shareCompletion : RShareCompletion?
    
    
    func sdkInitialize(appID : String, secret : String?) {
        FBSDKSettings.setAppID(appID)
    }
    
    override class func connect(c: (RShareSDKPlatform, RRegister) -> Void) {
        c(.Facebook, RRegister.shared)
    }
    
    class override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options : options)
        
    }
    
    class override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication:sourceApplication , annotation: annotation)
    }
    
    func share(webpageURL : String,
               quote : String,
               hashTag : String?,
               from : UIViewController,
               mode : ShareMode,
               completion : RShareCompletion?) {
        
        if mode == .Native && !RPlatform.isInstalled(platform: .Facebook) {
            print("Facebook 未安装")
            return
        }
        shareCompletion = completion
        let content = RFacebookHelper.getLinkContent(webpageURL: webpageURL, quote: quote, hashTag: hashTag)
        let dialog = FBSDKShareDialog.show(from: from, with: content, delegate: self)
        dialog?.mode = RFacebookHelper.getMode(mode: mode)
        
        if (dialog?.canShow())! {
            dialog?.show()
        } else {
            guard shareCompletion != nil else { return }
            shareCompletion!(.Facebook, .Failure, "Facebook 分享失败")
        }
    }
    func share(photos : Array<UIImage>,
               from : UIViewController,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .Facebook) {
            print("Facebook 未安装")
            return
        }
        shareCompletion = completion
        assert(photos.count < 6, "图片个数不能超过 6")
        let content = RFacebookHelper.getPhotosContent(photos: photos)
        let dialog = FBSDKShareDialog.show(from: from, with: content, delegate: self)
        if (dialog?.canShow())! {
            dialog?.show()
        } else {
            guard shareCompletion != nil else { return }
            shareCompletion!(.Facebook, .Failure, "Facebook 分享失败")
        }
    }
    func share(localVideoURL : URL,
               from : UIViewController) {
        if !RPlatform.isInstalled(platform: .Facebook) {
            print("Facebook 未安装")
            return
        }
        let content = RFacebookHelper.getVideoContent(localVideoURL: localVideoURL)
        let dialog = FBSDKShareDialog.show(from: from, with: content, delegate: self)
        if (dialog?.canShow())! {
            dialog?.show()
        }
    }

}
extension RFacebookManager : FBSDKSharingDelegate {
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        if shareCompletion != nil {
            shareCompletion!(.Facebook, .Cancel , nil)
        }
    }
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        if shareCompletion != nil {
            shareCompletion!(.Facebook, .Failure , error.localizedDescription)
        }
    }
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        if shareCompletion != nil {
            shareCompletion!(.Facebook, .Success , nil)
        }
    }
    
}
extension RFacebookManager {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
}
