//
//  RQqManager.swift
//  share
//
//  Created by valenti on 2018/7/19.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

enum RQQShareScene : UInt64 {
    case Automatic = 0x04
    case Favorites = 0x08
    case Dataline = 0x10
}

class RQqManager: RShare {
    
    static let  shared = RQqManager()
    private override init() {}
    
    
    private(set) var resultCode : QQApiSendResultCode? {
        didSet {
            
            guard shareCompletion != nil else {
                return
            }
            switch resultCode {
            case EQQAPIAPPNOTREGISTED:
                shareCompletion!(.QQ, .Failure, "应用未注册")
            case EQQAPIMESSAGECONTENTNULL: fallthrough
            case EQQAPIMESSAGETYPEINVALID: fallthrough
            case EQQAPIMESSAGECONTENTINVALID :
                shareCompletion!(.QQ, .Failure, "参数错误")
            case EQQAPIQQNOTINSTALLED:
                shareCompletion!(.QQ, .Failure, "应用未安装")
            case EQQAPIQQNOTSUPPORTAPI:
                shareCompletion!(.QQ, .Failure, "不支持的客户端")
            case EQQAPISENDFAILD:
                shareCompletion!(.QQ, .Failure, "发送失败")
            case EQQAPIVERSIONNEEDUPDATE:
                shareCompletion!(.QQ, .Failure, "QQ版本过低")
            case EQQAPIQZONENOTSUPPORTTEXT:
                shareCompletion!(.QQ, .Failure, "QQ空间不支持的 Text 类型分享!")
            case EQQAPIQZONENOTSUPPORTIMAGE:
                shareCompletion!(.QQ, .Failure, "QQ空间不支持的 Image 类型分享!")
                
                
            default:
                break
            }
        }
    }
    
    fileprivate var shareCompletion : RShareCompletion?
    
    func sdkInitialize(appID : String, appKey : String?) {
        let _ = TencentOAuth(appId: appID, andDelegate: self)
    }
    
    
    func share(text : String, scene : RQQShareScene, completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .QQ) {
            print("QQ 未安装")
            return
        }
        shareCompletion = completion
        resultCode = QQApiInterface.send(RQqHelper.getTextReqToQQ(text: text, scene: scene))
    }
    
    func share(image : UIImage,
               title : String,
               description : String,
               scene : RQQShareScene,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .QQ) {
            print("QQ 未安装")
            return
        }
        shareCompletion = completion
        resultCode = QQApiInterface.send(RQqHelper.getImageReqToQQ(image: image, title: title, description: description, scene: scene))
    }
    
    func share(webpageURL : String,
               title : String,
               description : String,
               thumbImage : UIImage,
               scene : RQQShareScene,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .QQ) {
            print("QQ 未安装")
            return
        }
        shareCompletion = completion
        resultCode = QQApiInterface.send(RQqHelper.getWebpageReqToQQ(webpageURL: webpageURL, title: title, description: description, thumbImageData: UIImageJPEGRepresentation(thumbImage, 1.0)!, scene: scene))
    }
    
    func share(videoURL : String,
               title : String,
               description : String,
               thumbImage : UIImage,
               scene : RQQShareScene,
               completion : RShareCompletion?) {
        
        if !RPlatform.isInstalled(platform: .QQ) {
            print("QQ 未安装")
            return
        }
        shareCompletion = completion
        resultCode = QQApiInterface.send(RQqHelper.getVideoReqToQQ(videoURL: videoURL, title: title, description: description, thumbImageData: UIImageJPEGRepresentation(thumbImage, 1.0)!, scene: scene))
    }
    
    func share(audioStreamURL : String,
               title : String,
               description : String,
               thumbImage : UIImage,
               webpageURL : String,
               scene : RQQShareScene,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .QQ) {
            print("QQ 未安装")
            return
        }
        shareCompletion = completion
        resultCode = QQApiInterface.send(RQqHelper.getAudioReqToQQ(audioStreamURL: audioStreamURL, title: title, description: description, thumbImageData: UIImageJPEGRepresentation(thumbImage, 1.0)!, webpageURL: webpageURL, scene: scene))
    }
    
    func share(text : String,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .QQ) {
            print("QQ 未安装")
            return
        }
        shareCompletion = completion
        resultCode = QQApiInterface.sendReq(toQZone: RQqHelper.getTextReqToQZone(text: text))
    }
    
    func share(images : Array<UIImage>,
               description : String,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .QQ) {
            print("QQ 未安装")
            return
        }
        shareCompletion = completion
        resultCode = QQApiInterface.sendReq(toQZone: RQqHelper.getImagesReqToQZone(images: images, description: description))
    }
    func share(videoAssetURL : URL,
               description : String,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .QQ) {
            print("QQ 未安装")
            return
        }
        shareCompletion = completion
        resultCode = QQApiInterface.sendReq(toQZone: RQqHelper.getLocalVideoReqToQZone(videoAssetURL: videoAssetURL, description: description))
    }

}


extension RQqManager {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        QQApiInterface.handleOpen(url, delegate: self)
        if TencentOAuth.canHandleOpen(url) {
            return TencentOAuth.handleOpen(url)
        }
        return true
        
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        QQApiInterface.handleOpen(url, delegate: self)
        if TencentOAuth.canHandleOpen(url) {
            return TencentOAuth.handleOpen(url)
        }
        return true
    }
}

extension RQqManager : TencentSessionDelegate {
    
    func tencentDidLogin() {}
    func tencentDidNotLogin(_ cancelled: Bool) {}
    func tencentDidNotNetWork() {}
}
extension RQqManager : QQApiInterfaceDelegate {
    
    func onReq(_ req: QQBaseReq!) {}
    func onResp(_ resp: QQBaseResp!) {
        
        
        guard shareCompletion != nil else { return }
        if resp is SendMessageToQQResp {
            if resp.result == "0" {
                shareCompletion!(.QQ, .Success, nil)
            } else if resp.result == "-4" {
                shareCompletion!(.QQ, .Cancel, nil)
            } else {
                shareCompletion!(.QQ, .Failure, resp.errorDescription)
            }
        }
        
    }
    func isOnlineResponse(_ response: [AnyHashable : Any]!) {}
}
