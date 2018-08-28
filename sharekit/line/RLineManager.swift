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
    
    fileprivate let lineURLPrefix = "line://msg/"
    fileprivate var lineURL : URL?
    
    override class func connect(c: (RShareSDKPlatform, RRegister) -> Void) {
        c(.Line, RRegister.shared)
    }
    
    func share(text : String) {
        
        if !RPlatform.isInstalled(platform: .Line) {
            print("Line 未安装")
            return
        }
        
        lineURL = URL(string: lineURLPrefix + "text/?" + text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        if UIApplication.shared.canOpenURL(lineURL!) {
            UIApplication.shared.openURL(lineURL!)
        }
        
    }
    
    func share(image : UIImage) {
        
        if !RPlatform.isInstalled(platform: .Line) {
            print("Line 未安装")
            return
        }

        let p = UIPasteboard.general
        p.setData(UIImageJPEGRepresentation(image, 0.1)!, forPasteboardType: "public.jpeg")
        
        lineURL = URL(string: String(format: lineURLPrefix + "image/%@", p.name as CVarArg))
        if UIApplication.shared.canOpenURL(lineURL!) {
            UIApplication.shared.openURL(lineURL!)
        }
    }
}
