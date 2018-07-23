//
//  RWhatsAppManager.swift
//  share
//
//  Created by valenti on 2018/7/23.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RWhatsAppManager: RShare {
    
    static let  shared = RWhatsAppManager()
    private override init() {}
    
    fileprivate var from : UIViewController? = nil
    fileprivate var dc : UIDocumentInteractionController? = nil
    
    
    func share(text : String) {
        
        if !RPlatform.isInstalled(platform: .WhatsApp) {
            print("WhatsApp 未安装")
            return
        }
        
        let whatsappString = "whatsapp://send?text=" + text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let whatsappURL = URL (string: whatsappString)
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.openURL(whatsappURL!)
        }
        
    }
    func share(image : UIImage, from : UIViewController) {
        
        if !RPlatform.isInstalled(platform: .WhatsApp) {
            print("WhatsApp 未安装")
            return
        }
        self.from = from
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("whatsAppTmp.jpg")
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        
        do {
            try imageData?.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
        }
        
        dc = UIDocumentInteractionController(url: fileURL)
        dc?.delegate = self
        dc?.uti = "net.whatsapp.image"
        dc?.presentOpenInMenu(from: from.view.bounds, in: from.view, animated: true)
        
    }

}
extension RWhatsAppManager : UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return from!
    }
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return from!.view
    }
    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return from!.view.bounds
    }
}
