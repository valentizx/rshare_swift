//
//  RGooglePlusManager.swift
//  share
//
//  Created by valenti on 2018/7/23.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit
import SafariServices

class RGooglePlusManager: RShare, SFSafariViewControllerDelegate {
    
    
    static let  shared = RGooglePlusManager()
    private override init() {}
    
    func share(webpageURL : URL, from : ViewController) {
        var components = URLComponents(string: "https://plus.google.com/share")
        components?.queryItems = [URLQueryItem(name: "url", value: webpageURL.absoluteString)]
        let url = components?.url
        
        
        
        if #available(iOS 9, *) {
            let vc = SFSafariViewController(url: url!)
            vc.delegate = self
            from.present(vc, animated: true, completion: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    
}
