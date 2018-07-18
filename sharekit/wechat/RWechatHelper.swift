//
//  RWechatHelper.swift
//  share
//
//  Created by valenti on 2018/7/18.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RWechatHelper: NSObject {
    

    private var msg : WXMediaMessage = WXMediaMessage()
    
    private var req : SendMessageToWXReq = SendMessageToWXReq()
    
    
    func getTextMessageReq(text : String, scene : RWXTargetScene) -> SendMessageToWXReq {
        req.bText = true
        req.text = text
        req.scene = getScene(scene: scene)
        return req
    }
    
    func getImageMessageReq(image : UIImage, scene : RWXTargetScene) -> SendMessageToWXReq {
        
        msg.mediaObject = getImageObj(image: image)
        msg.messageAction = buildAction(flag: "image")
        
        req.bText = false
        req.message = msg
        req.scene = getScene(scene: scene)
        return req
    }
    
    func getWebpageMessageReq(webpageURL : String,
                              title : String,
                              description : String,
                              thumbImage : UIImage,
                              scene : RWXTargetScene) -> SendMessageToWXReq {
        msg.mediaObject = getWebapgeObj(webpageURL: webpageURL)
        msg.messageAction = buildAction(flag: "webpage")
        msg.description = description
        msg.title = title
        msg.setThumbImage(thumbImage)
        
        req.bText = false
        req.message = msg
        req.scene = getScene(scene: scene)
        return req
    }
    
    func getVideoMessageReq(videoURL : String,
                            title : String,
                            description : String,
                            thumbImage: UIImage,
                            scene : RWXTargetScene) -> SendMessageToWXReq {
        msg.mediaObject = getVideoObj(videoURL: videoURL)
        msg.messageAction = buildAction(flag: "video")
        msg.description = description
        msg.title = title
        msg.setThumbImage(thumbImage)
        
        req.bText = false
        req.message = msg
        req.scene = getScene(scene: scene)
        return  req
    }
    
    func getMusicMessageReq(audioStreamURL : String,
                            webpageURL : String,
                            title : String,
                            description : String ,
                            thumbImage : UIImage,
                            scene : RWXTargetScene) -> SendMessageToWXReq {
        msg.mediaObject = getMusicObj(audioStreamURL: audioStreamURL, webpageURL: webpageURL)
        msg.messageAction = buildAction(flag: "music")
        msg.description = description
        msg.title = title
        msg.setThumbImage(thumbImage)
        
        req.bText = false
        req.message = msg
        req.scene = getScene(scene: scene)
        return req
    }
    
    func getMiniProgramMessageReq(userName : String,
                                  path : String,
                                  type : RWXMiniProgramType,
                                  webpageURL : String,
                                  title : String,
                                  description : String,
                                  thumbImage : UIImage,
                                  scene : RWXTargetScene) -> SendMessageToWXReq {
        msg.mediaObject = getMiniProgramObj(userName: userName, path: path, type: type, webpageURL: webpageURL)
        msg.messageAction = buildAction(flag: "miniprogram")
        msg.description = description
        msg.title = title
        msg.setThumbImage(thumbImage)
        
        req.bText = false
        req.message = msg
        req.scene = getScene(scene: scene)
        return req
    }
    
    func getFileMessageReq(fileData : Data,
                           extensionName : String,
                           title : String,
                           thumbImage : UIImage,
                           scene : RWXTargetScene) -> SendMessageToWXReq {
        msg.mediaObject = getFileObj(fileData: fileData, extensionName: extensionName)
        msg.messageAction = buildAction(flag: "file")
        msg.title = title
        msg.setThumbImage(thumbImage)
        
        req.bText = false
        req.message = msg
        req.scene = getScene(scene: scene)
        return req
    }
    
    
    
    
    
    // =========
    
    private func getImageObj(image : UIImage) -> WXImageObject {

        let obj = WXImageObject()
        obj.imageData = UIImagePNGRepresentation(image)
        return obj
    }
    
    private func getWebapgeObj(webpageURL : String) -> WXWebpageObject {
        let obj = WXWebpageObject()
        obj.webpageUrl = webpageURL
        return obj
    }
    
    private func getVideoObj(videoURL : String) -> WXVideoObject {
        let obj = WXVideoObject()
        obj.videoUrl = videoURL
        return obj
    }
    
    private func getMusicObj(audioStreamURL : String , webpageURL : String) -> WXMusicObject {
        let obj = WXMusicObject()
        obj.musicUrl = audioStreamURL
        obj.musicUrl = webpageURL
        return obj
    }
    
    private func getMiniProgramObj(userName : String,
                                   path : String ,
                                   type : RWXMiniProgramType,
                                   webpageURL : String) -> WXMiniProgramObject {
        let obj = WXMiniProgramObject()
        obj.webpageUrl = webpageURL
        obj.userName = userName
        obj.path = path
        obj.miniProgramType = getMiniProgramType(type: type)
        return obj
    }
    
    private func getFileObj(fileData : Data, extensionName : String) -> WXFileObject {
        let obj = WXFileObject()
        obj.fileData = fileData
        obj.fileExtension = extensionName
        return obj
    }
    
}

extension RWechatHelper {
    
    fileprivate func getScene(scene : RWXTargetScene) -> Int32 {
        switch scene {
        case .Session:
            return Int32(WXSceneSession.rawValue)
        case .Favorite:
            return Int32(WXSceneFavorite.rawValue)
        case .Timeline:
            return Int32(WXSceneTimeline.rawValue)
    
        }
    }
    
    fileprivate func buildAction (flag : String) -> String {
        let date = Date()
        let stampString = "\(date.timeIntervalSince1970)"
        return stampString + flag
    }
    
    fileprivate func getMiniProgramType(type : RWXMiniProgramType) -> WXMiniProgramType {
        switch type {
        case .Preview:
            return WXMiniProgramType.preview
        case .Release:
            return WXMiniProgramType.release
        case .Test:
            return WXMiniProgramType.test
        }
    }
}
