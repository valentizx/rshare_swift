//
//  RTwitterManager.swift
//  share
//
//  Created by valenti on 2018/7/19.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RTwitterManager: RShare {
    static let  shared = RTwitterManager()
    private override init() {}
    
    
    fileprivate let authHelper = RTwitterAuthHepler.shared
    
    func sdkInitialize(consumerKey : String, consumerSecret : String) {
        TWTRTwitter.sharedInstance().start(withConsumerKey: consumerKey, consumerSecret: consumerSecret)
    }
    func share(webpageURL : String?,
               text : String?,
               image : UIImage?,
               from : UIViewController,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .Twitter) {
            print("Twitter 未安装")
            return
        }
        
        assert( webpageURL != nil || image != nil || text != nil, "网页、文本描述以及图片不能三者同时为空")
        if authHelper.hasLogged {
            let composer = TWTRComposer()
            if webpageURL != nil { composer.setURL(URL(string: webpageURL!)) }
            composer.setText(text)
            composer.setImage(image)
            composer.show(from: from) { (result) in
                if completion != nil {
                    switch result {
                    case TWTRComposerResult.done:
                        completion!(.Twitter, .Success, nil)
                    case TWTRComposerResult.cancelled:
                        completion!(.Twitter, .Cancel, nil)
                    }
                }
            }
        } else {
            authHelper.authorizeTwitter { (state, errorInfo) in
                switch state {
                case .Success: do {
                    let composer = TWTRComposer()
                    if webpageURL != nil { composer.setURL(URL(string: webpageURL!)) }
                    composer.setText(text)
                    composer.setImage(image)
                    composer.show(from: from) { (result) in
                        if completion != nil {
                            switch result {
                            case TWTRComposerResult.done:
                                completion!(.Twitter, .Success, nil)
                            case TWTRComposerResult.cancelled:
                                completion!(.Twitter, .Cancel, nil)
                            }
                        }
                    }
                    }
                case .Failure: do {
                    if completion != nil {
                        completion!(.Twitter, .Failure, "Twitter 授权失败")
                    }
                    }
                }
            }
        }
    }
}
extension RTwitterManager {
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return RTwitterAuthHepler.shared.application(app, open: url, options : options)
    }
}
