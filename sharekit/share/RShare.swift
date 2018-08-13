//
//  RShare.swift
//  sharekit
//
//  Created by valenti on 2018/7/17.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit


enum ShareResult {
    
    case Success

    case Cancel
    
    case Failure
}

enum ShareMode {
    /**
     @Displays 优先选择原生应用分享, 原生应用未安装的情况可能跳转内置 WebView 或者 Safari 进行分享.
     */
    case Automatic
    /**
     @Displays 原生应用分享.
     */
    case Native
    /**
     @Displays 应用内置 UIWebView 分享.
     */
    case Web
    /**
     @Displays the dialog in the iOS integrated share sheet, 仅对 Facebook 分享有效.
     */
    case Sheet
    /**
     @Displays 跳转至 Safari 分享, 仅对 Facebook 分享有效.
     */
    case Browser
    /**
     @Displays 跳转至 Safari 进行 Feed 形式的分享, 仅对 Facebook 分享有效.
     */
    case FeedBrowser
    /**
     @Displays 应用内置 UIWebView 的 Feed 形式分享, 仅对 Facebook 分享有效.
     */
    case Feed
    /**
     @Displays iOS 的系统分享, 通过 Document Interaction 搭建分享凭借, 仅对 Instagram 有效.
     */
    case System
}

typealias RShareCompletion = (_ paltform : RShareSDKPlatform,_ result : ShareResult,_ errorInfo : String?) -> Void

class RShare: NSObject {
    
    class func connect(c : RConfiguration) {}
    
    class func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return false
        
    }
    class func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return false
    }
    

}
