//
//  RWechatManager.swift
//  share
//
//  Created by valenti on 2018/7/18.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit


enum RWXTargetScene {
    case Session
    case Timeline
    case Favorite
}
enum RWXMiniProgramType {
    case Release
    case Test
    case Preview
}


private struct TypeFlag : OptionSet {
    
    let rawValue: UInt64
    
    static let Text = TypeFlag(rawValue: enAppSupportContentFlag.MMAPP_SUPPORT_TEXT.rawValue)
    static let Picture = TypeFlag(rawValue: enAppSupportContentFlag.MMAPP_SUPPORT_PICTURE.rawValue)
    static let Video = TypeFlag(rawValue: enAppSupportContentFlag.MMAPP_SUPPORT_VIDEO.rawValue)
    static let Audio = TypeFlag(rawValue: enAppSupportContentFlag.MMAPP_SUPPORT_AUDIO.rawValue)
    static let Webpage = TypeFlag(rawValue: enAppSupportContentFlag.MMAPP_SUPPORT_WEBPAGE.rawValue)
    
    
    
}

class RWechatManager: RShare {
    
    static let  shared = RWechatManager()
    private override init() {}
    
    fileprivate var shareCompletion : RShareCompletion?
    private let helper : RWechatHelper = RWechatHelper()
    
    func sdkInitialize(appID : String, appSecret : String?) -> Void {
        let typeFlag : TypeFlag = [.Text, .Picture, .Video, .Audio, .Webpage]
        WXApi.registerAppSupportContentFlag(typeFlag.rawValue)
        WXApi.registerApp(appID)
    }
    
    override class func connect(c: (RShareSDKPlatform, RRegister) -> Void) {
        c(.Wechat, RRegister.shared)
    }
    class override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: RWechatManager.shared)
    }
    class override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WXApi.handleOpen(url, delegate: RWechatManager.shared)
    }
    
    func share(text : String, scene : RWXTargetScene, completion : RShareCompletion?) {
        
        if (!RPlatform.isInstalled(platform: .Wechat)) {
            print("微信未安装")
            return
        }
        shareCompletion = completion
        let req = helper.getTextMessageReq(text: text, scene: scene)
        WXApi.send(req)
        
    }
    func share(image : UIImage, scene:RWXTargetScene , completion : RShareCompletion?) {
        if (!RPlatform.isInstalled(platform: .Wechat)) {
            print("微信未安装")
            return
        }
        shareCompletion = completion
        let req = helper.getImageMessageReq(image: image, scene: scene)
        WXApi.send(req)
    }
    
    func share(webpageURL : String,
               title : String,
               description : String,
               thumbImage : UIImage,
               scene : RWXTargetScene,
               completion : RShareCompletion?) {
        if (!RPlatform.isInstalled(platform: .Wechat)) {
            print("微信未安装")
            return
        }
        shareCompletion = completion
        let req = helper.getWebpageMessageReq(webpageURL: webpageURL, title: title, description: description, thumbImage: thumbImage, scene: scene)
        WXApi.send(req)
    }
    func share(video videoURL : String,
               title : String,
               description : String,
               thumbImage : UIImage,
               scene : RWXTargetScene,
               completion : RShareCompletion?) {
        if (!RPlatform.isInstalled(platform: .Wechat)) {
            print("微信未安装")
            return
        }
        shareCompletion = completion
        let req = helper.getVideoMessageReq(videoURL: videoURL, title: title, description: description, thumbImage: thumbImage, scene: scene)
        WXApi.send(req)
    }
    
    func share(audioStreamURL : String,
               webpageURL : String,
               title : String,
               description : String,
               thumbImage : UIImage,
               scene : RWXTargetScene,
               completion : RShareCompletion?) {
        
        if (!RPlatform.isInstalled(platform: .Wechat)) {
            print("微信未安装")
            return
        }
        shareCompletion = completion
        let req = helper.getMusicMessageReq(audioStreamURL:audioStreamURL , webpageURL: webpageURL, title: title, description: description, thumbImage: thumbImage, scene: scene)
        WXApi.send(req)
        
    }
    
    func shareMiniProgram(userName : String,
                          path : String,
                          type : RWXMiniProgramType,
                          webpageURL : String,
                          title : String,
                          description : String,
                          thumbImage : UIImage,
                          scene : RWXTargetScene,
                          completion : RShareCompletion?) {
        if (!RPlatform.isInstalled(platform: .Wechat)) {
            print("微信未安装")
            return
        }
        shareCompletion = completion
        let req = helper.getMiniProgramMessageReq(userName: userName, path: path, type: type, webpageURL: webpageURL, title: title, description: description, thumbImage: thumbImage, scene: scene)
        WXApi.send(req)
        
    }
    
    func share(fileData : Data,
               extensionName : String,
               title : String,
               thumbImage : UIImage,
               scene : RWXTargetScene,
               completion : RShareCompletion?)  {
        if (!RPlatform.isInstalled(platform: .Wechat)) {
            print("微信未安装")
            return
        }
        shareCompletion = completion
        let req = helper.getFileMessageReq(fileData: fileData, extensionName: extensionName, title: title, thumbImage: thumbImage, scene: scene)
        WXApi.send(req)
        
    }
    
}

extension RWechatManager: WXApiDelegate {
    
    func onReq(_ req: BaseReq!) {}
    func onResp(_ resp: BaseResp!) {
        
        guard shareCompletion != nil else {
            return
        }
        switch resp.errCode {
        case 0:
            shareCompletion!(.Wechat, .Success, nil)
        case -2:
            shareCompletion!(.Wechat, .Cancel, nil)
            
        default:
            shareCompletion!(.Wechat, .Failure, resp.errStr)
        }
    }
    
}
