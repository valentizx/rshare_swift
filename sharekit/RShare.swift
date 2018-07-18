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

enum Mode {
    /**
     @Displays 优先选择原生应用分享, 原生应用未安装的情况可能跳转内置 WebView 或者 Safari 进行分享.
     */
    case ShareModeAutomatic
    /**
     @Displays 原生应用分享.
     */
    case ShareModeNative
    /**
     @Displays 应用内置 UIWebView 分享.
     */
    case ShareModeWeb
    /**
     @Displays the dialog in the iOS integrated share sheet, 仅对 Facebook 分享有效.
     */
    case ShareModeSheet
    /**
     @Displays 跳转至 Safari 分享, 仅对 Facebook 分享有效.
     */
    case ShareModeBrowser
    /**
     @Displays 跳转至 Safari 进行 Feed 形式的分享, 仅对 Facebook 分享有效.
     */
    case ShareModeFeedBrowser
    /**
     @Displays 应用内置 UIWebView 的 Feed 形式分享, 仅对 Facebook 分享有效.
     */
    case ShareModeFeed
    /**
     @Displays iOS 的系统分享, 通过 Document Interaction 搭建分享凭借, 仅对 Instagram 有效.
     */
    case ShareModeSystem
}

typealias RShareCompletion = (_ paltform : RShareSDKPlatform,_ result : ShareResult,_ errorInfo : String?) -> Void

class RShare: NSObject {

}
