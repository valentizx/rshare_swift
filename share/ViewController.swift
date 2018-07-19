//
//  ViewController.swift
//  share
//
//  Created by valenti on 2018/6/27.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var getVideoURLLabel : UILabel!
    
    
    
    private let wcManager = RWechatManager.shared
    private let wbManager = RSinaWeiboManager.shared
    private let qqManager = RQqManager.shared
    private let fbManager = RFacebookManager.shared
    private let twManager = RTwitterManager.shared
    
    private let videoWebpageURL = "https://www.youtube.com/watch?v=DSRSgMp5X1w"
    private let shareTitle = "Liberation"
    private let shareDescription = "流行天后 Christina Aguilera 时隔六年回归全新录音室专辑「Liberation」于 2018 年 6 月 15 日发布."
    private let hashTag = "#liberation"
    private let audioStreamURL = "http://10.136.9.109/fcgi-bin/fcg_music_get_playurl.fcg?song_id=1234&redirect=0&filetype=mp3&qqmusic_fromtag=15&app_id=100311325&app_key=b233c8c2c8a0fbee4f83781b4a04c595&device_id=1234"
    private let audioWebpageURL = "http://url.cn/5tZF9KT"
    private let netImageURL = "http://photocdn.sohu.com/20151211/Img430920125.jpg"
    
    private let webpageURL = "https://www.nytimes.com/2018/05/04/arts/music/playlist-christina-aguilera-kanye-west-travis-scott-dirty-projectors.html"
    private let thumbImage = #imageLiteral(resourceName: "c_1")
    
    private var localVideoURL : URL? // QQ 和 Facebook 可用
    private var localVideoURL2 : URL? // 新浪微博 和 Instagram 可用
    private var asset : PHAsset?
    
    private let shareCompletion : RShareCompletion =  { (p , state , errorInfo) in
        
        print(p)
        print(state)
        print(errorInfo as Any)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getVideoURLLabel.text = "1, 若分享本地视频, 请先点击「获取视频URL」按钮; \n2, 在分享本地视频的过程中, 注意 demo 中 localVideoURL 和 localVideoURL2 的区别⚠️."
    
    
    }

    @IBAction func shareFbWeb(_ sender: Any) {
        
        fbManager.sdkInitialize(appID: "234270717151331", secret: nil)
        fbManager.share(webpageURL: webpageURL, quote: shareDescription, hashTag: hashTag, from: self, mode: .Native, completion: shareCompletion)
        
    }
    @IBAction func shareFbPhotos(_ sender: Any) {
        fbManager.sdkInitialize(appID: "234270717151331", secret: nil)
        fbManager.share(photos: [#imageLiteral(resourceName: "c"), #imageLiteral(resourceName: "c"), #imageLiteral(resourceName: "c")], from: self, completion: shareCompletion)
    }
    
    @IBAction func shareFbVid(_ sender: Any) {
        fbManager.sdkInitialize(appID: "234270717151331", secret: nil)
        guard localVideoURL != nil else {
            print("请先获取视频 URL⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️")
            return
        }
        fbManager.share(localVideoURL: localVideoURL!, from: self)
    }
    
    @IBAction func shareFbMedia(_ sender: Any) {
    }
    
    @IBAction func shareTwWeb(_ sender: Any) {
        twManager.sdkInitialize(consumerKey: "cA72pVIFxOOWWfT8t9sFLcNUS", consumerSecret: "Rc9ornOaSWTFYqFzxDIEtIcsaWoxRcVGJs6U71kAjhHcGHyEZi")
        twManager.share(webpageURL: webpageURL, text: shareDescription, image: #imageLiteral(resourceName: "c"), from: self, completion: shareCompletion)
        
    }
    
    @IBAction func shareInsApp(_ sender: Any) {
    }
  
    @IBAction func shareInsSys(_ sender: Any) {
    }
   
    @IBAction func shareInsVid(_ sender: Any) {
    }
    @IBAction func shareTextWx(_ sender: Any) {
        wcManager.sdkInitialize(appID: "wxd471bcf3a21c7c4a", appSecret: "f71570ef272a5a6699decb264be9cdbb")
        wcManager.share(text: shareDescription, scene: .Session, completion: shareCompletion)
    }
    @IBAction func sharePhWx(_ sender: Any) {
        wcManager.sdkInitialize(appID: "wxd471bcf3a21c7c4a", appSecret: "f71570ef272a5a6699decb264be9cdbb")
        wcManager.share(image: #imageLiteral(resourceName: "c"), scene: .Session, completion: shareCompletion)
    }
    @IBAction func shareWebWx(_ sender: Any) {
        wcManager.sdkInitialize(appID: "wxd471bcf3a21c7c4a", appSecret: "f71570ef272a5a6699decb264be9cdbb")
        wcManager.share(webpageURL: webpageURL, title: shareTitle, description: shareDescription, thumbImage: thumbImage, scene: .Session, completion: shareCompletion)
    }
    @IBAction func shareVideoWx(_ sender: Any) {
        wcManager.sdkInitialize(appID: "wxd471bcf3a21c7c4a", appSecret: "f71570ef272a5a6699decb264be9cdbb")
        wcManager.share(video: videoWebpageURL, title: shareTitle, description:shareDescription , thumbImage: thumbImage , scene: .Session, completion : shareCompletion)
    
    }
    @IBAction func shareMsicWx(_ sender: Any) {
        wcManager.sdkInitialize(appID: "wxd471bcf3a21c7c4a", appSecret: "f71570ef272a5a6699decb264be9cdbb")
        wcManager.share(audioStreamURL: audioStreamURL, webpageURL: audioWebpageURL, title: shareTitle, description: shareDescription, thumbImage: thumbImage, scene: .Session, completion: shareCompletion)
    }
    @IBAction func shareMiniProgrWx(_ sender: Any) {
        wcManager.sdkInitialize(appID: "wxd471bcf3a21c7c4a", appSecret: "f71570ef272a5a6699decb264be9cdbb")
        wcManager.shareMiniProgram(userName: "gh_d43f693ca31f", path: "pages/play/index?cid=fvue88y1fsnk4w2&ptag=vicyao&seek=3219", type: .Release, webpageURL: webpageURL, title: shareTitle, description: shareDescription, thumbImage: thumbImage, scene: .Session, completion: shareCompletion)
        
    }
    @IBAction func shareFileWx(_ sender: Any) {
        
        let docExt = "docx"
        let videoExt = "mp4"
        let pdfExt = "pdf"
        
        let docPath = Bundle.main.path(forResource: "list", ofType: docExt)
        let videoPath = Bundle.main.path(forResource: "ca", ofType: videoExt)
        let pdfPath = Bundle.main.path(forResource: "Liberation", ofType: pdfExt)
    
        var docData : Data? = nil
        var videoData : Data? = nil
        var pdfData : Data? = nil
        
        do {
            docData  = try Data(contentsOf: URL(fileURLWithPath: docPath!))
            videoData = try Data(contentsOf: URL(fileURLWithPath: videoPath!))
            pdfData = try Data(contentsOf: URL(fileURLWithPath: pdfPath!))
        } catch {
            print(error)
        }
        
        wcManager.sdkInitialize(appID: "wxd471bcf3a21c7c4a", appSecret: "f71570ef272a5a6699decb264be9cdbb")
        wcManager.share(fileData: videoData!, extensionName: videoExt, title: shareTitle, thumbImage: thumbImage, scene: .Session, completion: shareCompletion)

    }
    
    @IBAction func shareTextWb(_ sender: Any) {
        
        wbManager.sdkInitialize(appKey: "3026908911", appSecret: "91fbafc7be7510c0ac5d73883c655db1")
        wbManager.share(text: shareDescription, completion: shareCompletion)
        
    }
    @IBAction func sharePhWb(_ sender: Any) {
        wbManager.sdkInitialize(appKey: "3026908911", appSecret: "91fbafc7be7510c0ac5d73883c655db1")
        wbManager.share(images: [#imageLiteral(resourceName: "c") , #imageLiteral(resourceName: "c"), #imageLiteral(resourceName: "c")], text: shareDescription, isToStory: false, completion: shareCompletion)
    }
    @IBAction func shareVidWb(_ sender: Any) {
        
        
        guard localVideoURL2 != nil else {
            print("请先获取视频 URL⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️")
            return
        }
        wbManager.sdkInitialize(appKey: "3026908911", appSecret: "91fbafc7be7510c0ac5d73883c655db1")
        
        wbManager.share(localVideoURL: localVideoURL2!, text: shareDescription, isToStory: false, completion: shareCompletion)
    }
    @IBAction func shareWebWb(_ sender: Any) {
        wbManager.share(webpageURL: webpageURL, objectID: "id", title: shareTitle, description: shareDescription, thumbImage: thumbImage, completion: shareCompletion)
    }
    @IBAction func shareTextQq(_ sender: Any) {
        qqManager.sdkInitialize(appID: "1106463933", appKey: "4WSrOXMoeFMDNR2k")
        qqManager.share(text: shareDescription, scene: .Automatic, completion: shareCompletion)
    }
    @IBAction func shareImgQq(_ sender: Any) {
        qqManager.sdkInitialize(appID: "1106463933", appKey: "4WSrOXMoeFMDNR2k")
        qqManager.share(image: #imageLiteral(resourceName: "c"), title: shareTitle, description: shareDescription, scene: .Automatic, completion: shareCompletion)
    }
    @IBAction func shareWebQq(_ sender: Any) {
        qqManager.sdkInitialize(appID: "1106463933", appKey: "4WSrOXMoeFMDNR2k")
        qqManager.share(webpageURL: webpageURL, title: shareTitle, description: shareDescription, thumbImage: #imageLiteral(resourceName: "c_1"), scene: .Automatic, completion: shareCompletion)
    }
    @IBAction func shareVidQq(_ sender: Any) {
        qqManager.sdkInitialize(appID: "1106463933", appKey: "4WSrOXMoeFMDNR2k")
        qqManager.share(videoURL: videoWebpageURL, title: shareTitle, description: shareDescription, thumbImage: #imageLiteral(resourceName: "c_1"), scene: .Automatic, completion: shareCompletion)
    }
    @IBAction func shareAudQq(_ sender: Any) {
        qqManager.sdkInitialize(appID: "1106463933", appKey: "4WSrOXMoeFMDNR2k")
        qqManager.share(audioStreamURL: audioStreamURL, title: shareTitle, description: shareDescription, thumbImage: #imageLiteral(resourceName: "c_1"), webpageURL: webpageURL, scene: .Automatic, completion: shareCompletion)
    }
    @IBAction func shareTextQz(_ sender: Any) {
        qqManager.sdkInitialize(appID: "1106463933", appKey: "4WSrOXMoeFMDNR2k")
        qqManager.share(text: shareDescription, completion: shareCompletion)
    }
    @IBAction func shareImgsQz(_ sender: Any) {
        qqManager.sdkInitialize(appID: "1106463933", appKey: "4WSrOXMoeFMDNR2k")
        qqManager.share(images: [#imageLiteral(resourceName: "c"), #imageLiteral(resourceName: "c"), #imageLiteral(resourceName: "c"), #imageLiteral(resourceName: "c")], description: shareDescription, completion: shareCompletion)
    }
    @IBAction func shareVidQz(_ sender: Any) {
        guard localVideoURL != nil else {
            print("请先获取视频 URL⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️")
            return
        }
        qqManager.sdkInitialize(appID: "1106463933", appKey: "4WSrOXMoeFMDNR2k")
        qqManager.share(videoAssetURL: localVideoURL!, description: shareDescription, completion: shareCompletion)
    }
    @IBAction func shareTextWsa(_ sender: Any) {
    }
    @IBAction func shareImgWsa(_ sender: Any) {
    }
    @IBAction func shareUrlGplus(_ sender: Any) {
    }
    @IBAction func shareTextTm(_ sender: Any) {
    }
    @IBAction func shareImgTm(_ sender: Any) {
    }
    @IBAction func getVideoURL(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.mediaTypes = ["public.movie", "public.video"]
        picker.videoQuality = .typeHigh
        picker.sourceType = .savedPhotosAlbum
        present(picker, animated: true, completion: nil)
        
    }
    
    
}
extension ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        picker.dismiss(animated: true) {
            self.localVideoURL2 = info[UIImagePickerControllerMediaURL] as? URL
            self.localVideoURL = info[UIImagePickerControllerReferenceURL] as? URL
            print("💚💚💚💚💚💚💚💚💚💚💚💚💚💚\(String(describing: self.localVideoURL?.absoluteString))")
            print("♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️\(String(describing: self.localVideoURL2?.absoluteString))")
        }
        
    }
}

