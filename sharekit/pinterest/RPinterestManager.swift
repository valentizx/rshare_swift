//
//  RPinterestManager.swift
//  share
//
//  Created by valenti on 2018/7/26.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RPinterestManager: RShare {
    
    static let  shared = RPinterestManager()
    private override init() {}
    
    func sdkInitialize(appID : String, appSecret : String?) {
        PDKClient .configureSharedInstance(withAppId: appID)
    }
    func share(imageURL : String,
               webpageURL : String,
               boardName : String,
               description : String,
               from : UIViewController,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .Pinterest) {
            NSLog("Pinterest 未安装")
            return
        }
        
        PDKPin.pin(withImageURL: URL(string: imageURL), link: URL(string: webpageURL), suggestedBoardName: boardName, note: description, from: from, withSuccess: {
            if completion != nil {
                completion!(.Pinterest, .Success, nil)
            }
            
        }) { (e) in
            let code = (e! as NSError).code
            if code == 1 {
                completion!(.Pinterest, .Cancel, nil)
            } else {
                completion!(.Pinterest, .Failure, e?.localizedDescription)
            }
        }
    }

}

extension RPinterestManager {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return PDKClient.sharedInstance().handleCallbackURL(url)
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return PDKClient.sharedInstance().handleCallbackURL(url)
    }
}
