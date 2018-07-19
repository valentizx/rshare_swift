//
//  RQqHelper.swift
//  share
//
//  Created by valenti on 2018/7/19.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

class RQqHelper: NSObject {

    class func getTextReqToQQ(text : String, scene : RQQShareScene) -> SendMessageToQQReq {
        
        let obj = QQApiTextObject(text: text)
        obj?.cflag = scene.rawValue
        let req = SendMessageToQQReq(content: obj)
        return req!
    }
    class func getImageReqToQQ(image : UIImage,
                               title : String,
                               description : String,
                               scene : RQQShareScene) -> SendMessageToQQReq {
        let imgData = UIImageJPEGRepresentation(image, 1)
        let obj = QQApiImageObject(data: imgData, previewImageData: imgData, title: title, description: description)
        obj?.cflag = scene.rawValue
        let req = SendMessageToQQReq(content: obj)
        return req!
    }
    class func getWebpageReqToQQ(webpageURL : String,
                                 title : String,
                                 description : String,
                                 thumbImageData : Data,
                                 scene : RQQShareScene) -> SendMessageToQQReq {
        let obj = QQApiNewsObject(url: URL(string: webpageURL), title: title, description: description, previewImageData: thumbImageData, targetContentType: QQApiURLTargetTypeNews)
        
        obj?.cflag = scene.rawValue
        let req = SendMessageToQQReq(content: obj)
        return req!
    }
    
    class func getVideoReqToQQ(videoURL : String,
                               title : String,
                               description : String,
                               thumbImageData : Data,
                               scene : RQQShareScene) -> SendMessageToQQReq {
        let obj = QQApiVideoObject(url: URL(string: videoURL), title: title, description: description, previewImageData: thumbImageData, targetContentType: QQApiURLTargetTypeVideo)
        obj?.cflag = scene.rawValue
        let req = SendMessageToQQReq(content: obj)
        return req!
    }
    class func getAudioReqToQQ(audioStreamURL : String,
                               title : String,
                               description : String,
                               thumbImageData : Data,
                               webpageURL : String,
                               scene : RQQShareScene) -> SendMessageToQQReq {
        
        let obj = QQApiAudioObject(url: URL(string: webpageURL), title: title, description: description, previewImageData: thumbImageData, targetContentType: QQApiURLTargetTypeAudio)
        obj?.flashURL = URL(string: audioStreamURL)
        obj?.cflag = scene.rawValue
        let req = SendMessageToQQReq(content: obj)
        return req!
        
    }
    
    class func getTextReqToQZone(text : String) -> SendMessageToQQReq {
        let obj = QQApiImageArrayForQZoneObject(imageArrayData: nil, title: text, extMap: nil)
        let req = SendMessageToQQReq(content: obj)
        return req!
    }
    
    class func getImagesReqToQZone(images : Array<UIImage>, description : String) -> SendMessageToQQReq {
        var datas : Array<Data> = Array<Data>()
        for i in 0 ..< images.count {
            datas.append(UIImageJPEGRepresentation(images[i], 1)!)
        }
        let obj = QQApiImageArrayForQZoneObject(imageArrayData: datas, title: description, extMap: nil)
        let req = SendMessageToQQReq(content: obj)
        return req!
    }
    
    class func getLocalVideoReqToQZone(videoAssetURL : URL, description : String) -> SendMessageToQQReq {
        let obj = QQApiVideoForQZoneObject(assetURL: videoAssetURL.absoluteString, title: description, extMap: nil)
        let req = SendMessageToQQReq(content: obj)
        return req!
        
    }
}
