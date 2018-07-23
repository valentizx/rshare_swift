//
//  RLineManager.swift
//  share
//
//  Created by valenti on 2018/7/20.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RLineManager: RShare {
    
    static let  shared = RLineManager()
    private override init() {}
    
    func share(text : String) {
        
        if !RPlatform.isInstalled(platform: .Line) {
            print("Line 未安装")
            return
        }
        
        let urlString = "line://msg/text/?" + text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: urlString)
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        }
        
    }
    
    func share(image : UIImage) {
        
        if !RPlatform.isInstalled(platform: .Line) {
            print("WhatsApp 未安装")
            return
        }

        let pasteboard = UIPasteboard.general
        pasteboard.setData(UIImageJPEGRepresentation(image, 0.1)!, forPasteboardType: "public.jpeg")
        
    
        let urlString = "line://msg/image/%@"
        
        let url = URL(string: String(format: urlString, pasteboard.name as CVarArg))
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        }
    }
}
