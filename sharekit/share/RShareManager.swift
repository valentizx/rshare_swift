//
//  RShareManager.swift
//  share
//
//  Created by valenti on 2018/8/3.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

typealias RConfiguration = (_ paltform : RShareSDKPlatform,_ obj : RRegister) -> Void

enum RShareChannel {
    
    case QQSession
    case QQFavorite
    case QQDataLine
    case QZone
    case WechatSession
    case WechatFavorite
    case WechatTimeline
    case FacebookClient
    case FacebookBroswer
    case Twitter
    case SinaWeibo
    case SinaWeiboStory
    case Line
    case Instagram
    case Tumblr
    case Pinterest
    case GooglePlus
    case WhatsApp
}

class RShareManager: NSObject {
    
    static let  shared = RShareManager()
    private override init() {}
    
    fileprivate(set) var objCls : RShare.Type = RShare.self
    
    func registerPlatform(platform : RPlatform, onConfiguration configuration: RConfiguration) {
        for p in platform.targets {
            p.connect(c: configuration)
        }
    }
    
    func shareImage(content : RImageContent,
                    channel : RShareChannel,
                    from : UIViewController,
                    completion : @escaping RShareCompletion) {
        
        objCls = getSubCls(channel: channel)
        
        switch channel {
        case .QQSession:
            RQqManager.shared.share(image: content.image!, title: content.title!, description: content.quote!, scene: .Automatic, completion: completion)
        case .QQFavorite:
            RQqManager.shared.share(image: content.image!, title: content.title!, description: content.quote!, scene: .Favorites, completion: completion)
        case .QQDataLine:
            RQqManager.shared.share(image: content.image!, title: content.title!, description: content.quote!, scene: .Dataline, completion: completion)
        case .QZone:
            RQqManager.shared.share(images: [content.image!], description: content.quote!, completion: completion)
        case .WechatSession:
            RWechatManager.shared.share(image: content.image!, scene: .Session, completion: completion)
        case .WechatFavorite:
            RWechatManager.shared.share(image: content.image!, scene: .Favorite, completion: completion)
        case .WechatTimeline:
            RWechatManager.shared.share(image: content.image!, scene: .Timeline, completion: completion)
        case .SinaWeibo:
            RSinaWeiboManager.shared.share(images: [content.image!], text: content.quote!, isToStory: false, completion: completion)
        case .SinaWeiboStory:
            RSinaWeiboManager.shared.share(images: [content.image!], text: content.quote!, isToStory: true, completion: completion)
        case .Tumblr:
            guard content.imageURL != nil else { break }
            RTumblrManager.shared.share(imageURL: content.imageURL!, description: content.quote!, webpageURL: content.webpageURL!, from: from, completion: completion)
        case .Line:
            RLineManager.shared.share(image: content.image!)
        case .Instagram:
            RInstagramManager.shared.share(image: content.image!)
        case .Pinterest:
            guard content.imageURL != nil else { break }
            RPinterestManager.shared.share(imageURL: content.imageURL!, webpageURL: content.webpageURL!, boardName: "", description: content.quote!, from: from, completion: completion)
        case .FacebookClient:
            RFacebookManager.shared.share(photos: [content.image!], from: from, completion: completion)
        default:
            print("⚠️ 该方式不支持视频分享!")
            break
        }
        
    }
    
    func shareVideo(content : RVideoContent,
                    channel : RShareChannel,
                    from : UIViewController,
                    completion : @escaping RShareCompletion) {
        objCls = getSubCls(channel: channel)
        
        var videoData : Data?
        do {
            videoData = try Data(contentsOf: (content.videoFileURL)!)
        } catch {
            print(error)
        }
        
        switch channel {
        case .QQDataLine:
            
            let fileName = String.randomFileName() + (content.videoFileURL?.path.extensionName)!
            RQqManager.shared.share(fileData: videoData!, fileName: fileName, title: content.title, description: content.quote, thumbImage: content.thumbImage!, compeltion: completion)
        case .QZone:
            RQqManager.shared.share(videoAssetURL: content.videoAssetURL!, description: content.quote!, completion: completion)
        case .WechatSession:
            RWechatManager.shared.share(fileData: videoData!, extensionName: (content.videoFileURL?.path.extensionName)!, title: content.title!, thumbImage: content.thumbImage!, scene: .Session, completion: completion)
        case .WechatTimeline:
            RWechatManager.shared.share(fileData: videoData!, extensionName: (content.videoFileURL?.path.extensionName)!, title: content.title!, thumbImage: content.thumbImage!, scene: .Favorite, completion: completion)
        case .SinaWeibo:
            RSinaWeiboManager.shared.share(localVideoURL: content.videoFileURL!, text: content.quote!, isToStory: false, completion: completion)
        case .SinaWeiboStory:
            RSinaWeiboManager.shared.share(localVideoURL: content.videoFileURL!, text: content.quote!, isToStory: true, completion: completion)
        case .Instagram:
            RInstagramManager.shared.share(localVideoURL: content.videoFileURL!, description: content.quote!)
        case .FacebookClient:
            RFacebookManager.shared.share(localVideoURL: content.videoAssetURL!, from: from)
            
        default:
            print("⚠️ 该方式不支持视频分享!")
            break;
        }
        
    }
    
    func shareWebapge(content : RWebpageContent,
                      channel : RShareChannel,
                      from : UIViewController,
                      completion : @escaping RShareCompletion) {
        objCls = getSubCls(channel: channel)
        switch channel {
        case .QQSession:
            RQqManager.shared.share(webpageURL: content.webpageURL!, title: content.title!, description: content.quote!, thumbImage: content.thumbImage!, scene: .Automatic, completion: completion)
        case .QQFavorite:
            RQqManager.shared.share(webpageURL: content.webpageURL!, title: content.title!, description: content.quote!, thumbImage: content.thumbImage!, scene: .Favorites, completion: completion)
        case .QQDataLine:
            RQqManager.shared.share(webpageURL: content.webpageURL!, title: content.title!, description: content.quote!, thumbImage: content.thumbImage!, scene: .Dataline, completion: completion)
        case .QZone:
            RQqManager.shared.share(text: content.webpageURL!, completion: completion)
        case .WechatSession:
            RWechatManager.shared.share(webpageURL: content.webpageURL!, title: content.title!, description: content.quote!, thumbImage: content.thumbImage!, scene: .Session, completion: completion)
        case .WechatFavorite:
            RWechatManager.shared.share(webpageURL: content.webpageURL!, title: content.title!, description: content.quote!, thumbImage: content.thumbImage!, scene: .Favorite, completion: completion)
        case .WechatTimeline:
            RWechatManager.shared.share(webpageURL: content.webpageURL!, title: content.title!, description: content.quote!, thumbImage: content.thumbImage!, scene: .Timeline, completion: completion)
        case .SinaWeibo:
            RSinaWeiboManager.shared.share(webpageURL: content.webpageURL!, objectID: "", title: content.title!, description: content.quote!, thumbImage: content.thumbImage!, completion: completion)
        case .Tumblr:
            RTumblrManager.shared.share(text: content.quote!, title: content.title!, webpageURL: content.webpageURL!, from: from, completion: completion)
        case .Line:
            RLineManager.shared.share(text: content.webpageURL!)
        case .WhatsApp:
            RWhatsAppManager.shared.share(text: content.webpageURL!)
        case .Twitter:
            RTwitterManager.shared.share(webpageURL: content.webpageURL, text: content.quote, image: content.thumbImage, from: from, completion: completion)
        case .FacebookClient:
            RFacebookManager.shared.share(webpageURL: content.webpageURL!, quote: content.quote!, hashTag: content.hashTag, from: from, mode: .Automatic, completion: completion)
        case .FacebookBroswer:
            RFacebookManager.shared.share(webpageURL: content.webpageURL!, quote: content.quote!, hashTag: content.hashTag, from: from, mode: .Browser, completion: completion)
        case .GooglePlus:
            RGooglePlusManager.shared.share(webpageURL: URL(string: content.webpageURL!)!, from: from)
        default:
            print("⚠️ 该方式不支持网页分享!")
            break;
        }
        
    }
    func shareText(content : RTextContent,
                   channel : RShareChannel,
                   from : UIViewController,
                   completion : @escaping RShareCompletion) {
        objCls = getSubCls(channel: channel)
        switch channel {
        case .QQSession:
            RQqManager.shared.share(text: content.body!, scene: .Automatic, completion: completion)
        case .QQDataLine:
            RQqManager.shared.share(text: content.body!, scene: .Dataline, completion: completion)
        case .QQFavorite:
            RQqManager.shared.share(text: content.body!, scene: .Favorites, completion: completion)
        case .QZone:
            RQqManager.shared.share(text: content.body!, completion: completion)
        case .SinaWeibo:
            RSinaWeiboManager.shared.share(text: content.body!, completion: completion)
        case .Tumblr:
            RTumblrManager.shared.share(text: content.body!, title: content.title!, webpageURL: content.webpageURL!, from: from, completion: completion)
        case .Line:
            RLineManager.shared.share(text: content.body!)
        case .WhatsApp:
            RWhatsAppManager.shared.share(text: content.body!)
        case .Twitter:
            RTwitterManager.shared.share(webpageURL: nil, text: content.body, image: nil, from: from, completion: completion)
        default:
            print("⚠️ 该方式不支持文字分享!")
            break;
        }
        
    }
}

extension RShareManager {
    
    func getSubCls(channel : RShareChannel) -> RShare.Type {
        switch channel {
        case .FacebookClient: fallthrough
        case .FacebookBroswer: return RFacebookManager.self
        case .Pinterest : return RPinterestManager.self
        case .WechatSession: fallthrough
        case .WechatFavorite: fallthrough
        case .WechatTimeline: return RWechatManager.self
        case .Twitter: return RTwitterManager.self
        case .SinaWeibo: fallthrough
        case .SinaWeiboStory : return RSinaWeiboManager.self
        case .QQSession: fallthrough
        case .QQDataLine: fallthrough
        case .QQFavorite: fallthrough
        case .QZone : return RQqManager.self
        default:
            return RShare.self
        }
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return objCls.application(app, open: url, options : options)
        
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return objCls.application(application, open: url, sourceApplication:sourceApplication , annotation: annotation)
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
}
