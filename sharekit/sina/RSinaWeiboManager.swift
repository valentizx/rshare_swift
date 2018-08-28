//
//  RSinaWeiboManager.swift
//  share
//
//  Created by valenti on 2018/7/18.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RSinaWeiboManager: RShare {
    
    static let  shared = RSinaWeiboManager()
    private override init() {}
    
    fileprivate var message : WBMessageObject? = WBMessageObject()
    fileprivate lazy var request : WBSendMessageToWeiboRequest? = ({
        return WBSendMessageToWeiboRequest.request(withMessage: message)
        }() as! WBSendMessageToWeiboRequest)
    
    fileprivate var shareCompletion : RShareCompletion?
    
    
    func sdkInitialize(appKey : String, appSecret : String)  {
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(appKey)
    }
    
    override class func connect(c: (RShareSDKPlatform, RRegister) -> Void) {
        c(.Sina, RRegister.shared)
    }
    
    class override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WeiboSDK.handleOpen(url, delegate: RSinaWeiboManager.shared)
    }
    class override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WeiboSDK.handleOpen(url, delegate: RSinaWeiboManager.shared)
    }
    
    
    func share(text : String, completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .Sina) {
            print("新浪微博未安装")
            return
        }
        shareCompletion = completion
        message?.text = text
        WeiboSDK.send(request)
    }
    
    func share(images : Array<UIImage>, text : String, isToStory : Bool , completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .Sina) {
            print("新浪微博未安装")
            return
        }
        shareCompletion = completion
        let obj = WBImageObject()
        obj.isShareToStory = isToStory
        obj.delegate = self
        obj.add(images)
        
        message?.imageObject = obj
        message?.text = text
        
    }
    func share(localVideoURL : URL,
               text : String,
               isToStory : Bool,
               completion : RShareCompletion?)  {
        if !RPlatform.isInstalled(platform: .Sina) {
            print("新浪微博未安装")
            return
        }
        shareCompletion = completion
        
        let obj = WBNewVideoObject()
        obj.isShareToStory = isToStory
        obj.delegate = self
        obj.addVideo(localVideoURL)
        
        message?.videoObject = obj
        message?.text = text
    }
    
    func share(webpageURL : String,
               objectID : String,
               title : String,
               description : String,
               thumbImage : UIImage,
               completion : RShareCompletion?) {
        if !RPlatform.isInstalled(platform: .Sina) {
            print("新浪微博未安装")
            return
        }
        let obj = WBWebpageObject()
        obj.title = title
        obj.description = description
        obj.objectID = objectID
        obj.thumbnailData = UIImagePNGRepresentation(thumbImage)
        obj.webpageUrl = webpageURL
        
        message?.mediaObject = obj
        message?.text = description
        
        WeiboSDK.send(request)
    }
}

extension RSinaWeiboManager : WeiboSDKDelegate, WBMediaTransferProtocol {
    
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {}
    
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        request = nil
        message = nil
        
        guard shareCompletion != nil else { return }
        
        if response.statusCode == .success {
            
            shareCompletion!(.Sina, .Success, nil)
            
        } else if response.statusCode == .userCancel {
            shareCompletion!(.Sina, .Cancel, nil)
            
        } else {
            shareCompletion!(.Sina, .Failure, "发送失败")
        }
        
    }
    
    
    func wbsdk_TransferDidReceive(_ object: Any!) {
        
        WeiboSDK.send(request)
        
    }
    func wbsdk_TransferDidFailWith(_ errorCode: WBSDKMediaTransferErrorCode, andError error: Error!) {
        guard shareCompletion != nil else { return }
        
        var errorInfo : String = ""
        

        if errorCode == .albumPermissionError {
            errorInfo = "相册权限不够"
        } else if errorCode == .albumWriteError {
            errorInfo = "相册写入错误"
        } else if errorCode == .albumAssetTypeError {
            errorInfo = "资源类型错误"
        } else {
            errorInfo = "参数准备错误"
        }
        message = nil
        shareCompletion!(.Sina, .Failure, errorInfo)
        
        
    }
}
