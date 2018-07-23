//
//  RInstagramManager.swift
//  share
//
//  Created by valenti on 2018/7/20.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RInstagramManager: RShare {
    
    static let  shared = RInstagramManager()
    private override init() {}
    

    
    fileprivate let instagramURL = URL(string: String(format: "instagram://library?AssetPath=%@", "" as CVarArg))
    
    func share(image : UIImage) {
        if !RPlatform.isInstalled(platform: .Instagram) {
            print("Instagram 未安装")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func share(localVideoURL : URL,
               description : String) {
        if !RPlatform.isInstalled(platform: .Instagram) {
            print("Instagram 未安装")
            return
        }
        UISaveVideoAtPathToSavedPhotosAlbum(localVideoURL.path, self, #selector(video(path:didFinishSavingWithError:contextInfo:)), nil)
        
    }

}
extension RInstagramManager {
    
    @objc fileprivate func image(image: UIImage!, didFinishSavingWithError error: NSError!, contextInfo: AnyObject!) {
        if UIApplication.shared.canOpenURL(instagramURL!) {
            UIApplication.shared.openURL(instagramURL!)
        }
        
    }
    
    @objc fileprivate func video(path: String!, didFinishSavingWithError error: NSError!, contextInfo: AnyObject!) {
        if UIApplication.shared.canOpenURL(instagramURL!) {
            UIApplication.shared.openURL(instagramURL!)
        }
    }
}
