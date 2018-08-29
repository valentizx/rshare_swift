# RSHARE Swift Version

RSHARE 这个 Demo 中支持: 微信、QQ、新浪微博、Facebook、GooglePlus(Google +)、Twitter、WhatsApp、Line、Tumblr、Instagram、Pinterest 11 个 Social 平台.

### QQ
#### 准备
分享需要注册平台, [腾讯开发者主页](http://open.qq.com/), [SDK 下载](http://wiki.open.qq.com/wiki/mobile/SDK%E4%B8%8B%E8%BD%BD), QQ SDK 目前**不支持 pod 安装**, iOS API 调用说明[文档](http://wiki.open.qq.com/index.php?title=iOS_API%E8%B0%83%E7%94%A8%E8%AF%B4%E6%98%8E&oldid=46716).
#### 集成
a. ``TencentOpenAPI.framework``导入项目中;
b. 添加系统依赖``Security.framework``、``SystemConfiguration.framework``、``CoreGraphic.framework``、``libsqilte3.0.tbd``、``CoreTelephony.framework``、``libz.tbd``.
c. 设置 **The Other Flags** 为 **-ObjC**.
d. 在``info.plist``文件的``CFBundleURLTypes``中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>tencentYOURAPPID</string>
</array>
```
e. 添加以下至白名单:

```objc
<string>mqq</string>
<string>mqqapi</string>
<string>mqqwpa</string>
<string>mqqbrowser</string>
<string>mttbrowser</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV4</string>
<string>wtloginmqq2</string>
<string>mqzone</string>
<string>mqzoneopensdk</string>
<string>mqzoneopensdkapi</string>
<string>mqzoneopensdkapi19</string>
<string>mqzoneopensdkapiV2</string>
<string>mqqapiwallet</string>
<string>mqqopensdkfriend</string>
<string>mqqopensdkdataline</string>
<string>mqqgamebindinggroup</string>
<string>mqqopensdkgrouptribeshare</string>
<string>tencentapi.qq.reqContent</string>
<string>tencentapi.qzone.reqContent</string>
```

f. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.

#### 接口调用

**a. 初始化 SDK**

```swift
RQqManager.shared.sdkInitialize(appID: yourAppId, appKey: yourAppKey)
```

**b. 分享**

**文字分享:**


```swift
RQqManager.shared.share(text: text, scene: scene, completion: completion)
```

**图片分享:**


```swift
RQqManager.shared.share(image: targetImage, title: title, description: description, scene: scene, completion: completion)
```


**网页分享:**


```swift
RQqManager.shared.share(webpageURL: webpageURL, title: title, description: description, thumbImage: image, scene: scene, completion: completion)
```


**视频链分享:**
实质就是网页的分享, 在此不作代码示例.

**音频链分享:**

```swift
RQqManager.shared.share(audioStreamURL: audioStreamURL, title: title, description: description, thumbImage: image, webpageURL: webpageURL, scene: scene, completion: completion)

```




**文件分享:**


```swift
RQqManager.shared.share(fileData: filedata, fileName: fileName, title: title, description: description, thumbImage: image, compeltion: completion)
```


**文字分享到 QQ 空间:**


```swift
RQqManager.shared.share(text: description, completion: completion)
```


**分享图片到 QQ 空间:**


```swift
RQqManager.shared.share(images: targetImageArray, description: description, completion: completion)
```

**分享本地视频到 QQ 空间:**



```swift
RQqManager.shared.share(videoAssetURL: videoAssetURL, description: description, completion: completion)
```


**c. 返回本应用**


```swift
RQqManager.application(app, open: url, options : options)
```

### 微信
#### 准备
分享需要注册平台, [微信开放平台](https://open.weixin.qq.com/), [SDK 下载](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=open1419319164&token=015161c07a6a155cf6424904a9febe4301efaa49&lang=zh_CN), 微信 SDK **支持 pod 安装**, [分享 & 收藏 API 调用说明](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=open1419317332&token=&lang=zh_CN).



#### 集成
a. 手动: ``libWeChatSDK.a``、``WXApi.h``、``WXApiObject.h``, 导入项目中;
pod 集成: ``pod 'WechatOpenSDK'``, 若出现:
> Use the $(inherited) flag, or
> Remove the build settings from the target.
> 🔧解决方法(引自[微信集成说明](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN), 未亲自测试): 把工程 target 中的 build Setting 里面 **PODS_ROOT** 的值替换成 **\$(inherited)**, **Other Linker Flags** 中 **-all_load** 替换成 **\$(inherited).**

b. 添加系统依赖 ``SystemConfiguration.framework``, ``libz.dylib``, ``libsqlite3.0.dylib``, ``libc++.dylib``, ``Security.framework``, ``CoreTelephony.framework``, ``CFNetwork.framework``.
c. 手动集成的情况下, 需设置 **The Other Flags** 为 **-ObjC**.
d. 在`` info.plist`` 文件的 ``CFBundleURLTypes`` 中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>wxYOURAPPID</string>
</array>
```
e. 添加以下至白名单:

```objc
<string>weixin</string>
<string>wechat</string>
```

f. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.

#### 接口调用

**a. 初始化 SDK**


```swift
RWechatManager.shared.sdkInitialize(appID: appID, appSecret: secret)
```

**b. 分享**


**文字分享:**


```swift
RWechatManager.shared.share(text: shareDescription, scene: scene, completion: shareCompletion)
```



**图片分享:**


```swift
RWechatManager.shared.share(image: targetImage, scene: scene, completion: completion)
```


**网页分享:**


```swift
RWechatManager.shared.share(webpageURL: webpageURL, title: title, description: description, thumbImage: thumbImage, scene: scene, completion: completion)
```

**视频链分享:**
实质就是网页的分享, 在此不作代码示例.


```swift
RWechatManager.shared.share(audioStreamURL: audioStreamURL, webpageURL: audioWebpageURL, title: title, description: description, thumbImage: thumbImage, scene: scene, completion: completion)
```

**小程序分享:**


```swift
RWechatManager.shared.shareMiniProgram(userName: userName, path: path, type: type, webpageURL: webpageURL, title: title, description: description, thumbImage: thumbImage, scene: scene, completion: completion)
```



**文件分享:**


```swift
RWechatManager.shared.share(fileData: fileData, extensionName: fileExtensionName, title: title, thumbImage: thumbImage, scene: scene, completion: completion)
```




**c. 返回本应用**


```swift
RWechatManager.application(app, open: url, options : options)
```

### 新浪
#### 准备

分享需要注册平台, [新浪开放平台](http://open.weibo.com/), [SDK 下载](http://open.weibo.com/wiki/SDK#iOS_SDK), 新浪 SDK **支持 pod 安装**, [iOS 接口调用文档](https://github.com/sinaweibosdk/weibo_ios_sdk).



#### 集成

a. 手动导入 ``WeiboSDK.h``、 ``WBHttpRequest.h``、``libWeiboSDK.a`` 和 ``WeiboSDK.bundle`` 到项目中.
pod 集成: ``pod "Weibo_SDK", :git => "https://github.com/sinaweibosdk/weibo_ios_sdk.git"`` (未实际测试过).

b. 添加系统依赖``QuartzCore.framework``、``SystemConfiguration.framework``、``ImageIO.framework``、``CoreGraphic.framework``、``Security.framework``、``libsqilte3.0.tbd``、``CoreTelephony.framework``、``CoreText.framework``、``libz.tbd``.
c. 设置 **The Other Flags** 为 **-ObjC**.
d. 在 ``info.plist`` 文件的 ``CFBundleURLTypes`` 中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>wbYOURAPPKEY</string>
</array>
```

e.对传输安全的支持, 在当下的 iOS 系统中，默认需要为每次网络传输建立 **SSL**, 所以需在 plist 中设置 **NSAppTransportSecurity 的 NSAllowsArbitraryLoads** 为 **YES**.

f. 解除原有 **ATS**设置在 iOS 10+ 的网络限制:

```objc
<key>sina.com.cn</key>
  	<dict>
  		<key>NSIncludesSubdomains</key>
  		<true/>
  		<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
  		<true/>
  		<key>NSExceptionMinimumTLSVersion</key>
  		<string>TLSv1.0</string>
  		<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
  		<false/>
  	</dict>
```

g. 添加以下至白名单:

```objc
<string>sinaweibohd</string>
<string>sinaweibo</string>
<string>weibosdk</string>
<string>weibosdk2.5</string>
```

h. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.

#### 接口调用

**a. 初始化 SDK**


```swift
RSinaWeiboManager.shared.sdkInitialize(appKey: YourAppKey, appSecret: YourAppSecret)
```

**b. 分享**


**文字分享:**


```swift
RSinaWeiboManager.shared.share(text: text, completion: completion)
```


**图片分享:**


```swift
RSinaWeiboManager.shared.share(images: images, text: text, isToStory: trueOrFalse, completion: completion)
```


**本地视频分享:**


```swift
RSinaWeiboManager.shared.share(localVideoURL: videoFileURL, text: text, isToStory: trueOrFalse, completion: completion)
```


**网页分享:**


```swift
RSinaWeiboManager.shared.share(webpageURL: webpageURL, objectID: "id", title: title, description: description, thumbImage: thumbImage, completion: completion)
```



**c. 返回本应用**

```swift
RSinaWeiboManager.application(app, open: url, options : options)
```


### Facebook
#### 准备
分享需要注册平台, [Facebook 开发者主页](https://developers.facebook.com/), Facebook SDK **支持 pod 集成**, [分享接口调用说明](https://developers.facebook.com/docs/sharing/ios).
#### 集成
a. pod 集成: ``pod 'FBSDKLoginKit'``
b. 在``info.plist``文件的``CFBundleURLTypes``中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>fbYOURAPPID</string>
</array>
<key>FacebookAppID</key>
<string>YOURAPPID</string>
<key>FacebookDisplayName</key>
<string>SOMENAME</string>
```
c. 添加以下至白名单:

```objc
<string>fbapi</string>
<string>fb-messenger-share-api</string>
<string>fbauth2</string>
<string>fbshareextension</string>
```

d. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.

#### 接口调用

**a. 初始化 SDK**

```swift
RFacebookManager.shared.sdkInitialize(appID: appID, secret: secret)
```

**b. 分享**

**网页分享:**

```swift
RFacebookManager.shared.share(webpageURL: webpageURL, quote: quote, hashTag: hashTag, from: context, mode: mode, completion: completion)
```



**图片分享:**



```swift
RFacebookManager.shared.share(photos: targetImageArray, from: context, completion: completion)
```

**本地视频分享:**

```swift
RFacebookManager.shared.share(localVideoURL: videoURL, from: context)
```


**C. 返回本应用**

```swift
RFacebookManager.application(app, open: url, options : options)
```

**d. 其他设置**

在完成 Facebook 登录、分享等操作的时候还需要连接本应用的 ``AppDelegate`` , 故在 ``didFinishLaunchingWithOptions`` 函数中添加:

```swift
RFacebookManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
```

当需要记录有多少用户激活的时候需要在 ``applicationDidBecomeActive`` 方法中添加:


```swift
RFacebookManager.shared.applicationDidBecomeActive(application)
```



### Twitter
#### 准备
分享需要注册平台, [Twitter 开发者主页](https://developer.twitter.com/content/developer-twitter/en.html), [注册应用主页](https://apps.twitter.com/), Twitter SDK **支持 pod 集成**, [分享接口调用说明](https://github.com/twitter/twitter-kit-ios/wiki/Compose-Tweets).

**⚠️: Twitter SDK 将于 2018/10/31 后不再进行维护, 但是不影响后续使用, 需自行维护, [Twitter 产品经理 Neil Shah 对 Twitter SDK 放弃维护迭代的声明博客](https://blog.twitter.com/developer/en_us/topics/tools/2018/discontinuing-support-for-twitter-kit-sdk.html).**
#### 集成
a. pod 集成: ``pod 'TwitterKit'``
b. 在 ``info.plist`` 文件的``CFBundleURLTypes``中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>twitterkit-YOURCONSUMERKEY</string>
</array>
```
c. 添加以下至白名单:

```objc
<string>twitter</string>
<string>twitterauth</string>
```

d. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.



#### 接口调用

**a. 初始化 SDK**


```swift
RTwitterManager.shared.sdkInitialize(consumerKey: consumerKey, consumerSecret: secret)
```


**b. 授权 Twitter 客户端**

登录(授权回调):


```swift
typealias RTWAuthCompletion = (_ state : RTWAuthState,_ errorInfo : String?) -> Void
```

**判断是否登录过:**


```swift
let _ = RTwitterAuthHepler.shared.hasLogged
```

**登录授权:**


```swift
RTwitterAuthHepler.shared.authorizeTwitter { (state, errorInfo) in
    // some code ...
}
```

**返回本应用:**

```swift
RTwitterManager.application(app, open: url, options : options)
```
**c. 分享**

```swift
RTwitterManager.shared.share(webpageURL: webpageURL, text: text, image: image, from: context, completion: completion)
```


### Instagram
#### 准备

分享无需注册平台无需 SDK, [Instagram 开发者主页](https://www.instagram.com/developer/), [Custom URL Scheme 方式分享](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/).

#### 配置

在```info.plist```文件中:
添加以下至白名单:

```objc
<string>instagram</string>
```

#### 接口调用

**分享**

**分享图片:**


```swift
RInstagramManager.shared.share(image: targetImage)
```

**分享本地视频:**


```swift
RInstagramManager.shared.share(localVideoURL: videoFileURL!, description: description)
```



### Tumblr
#### 准备
分享需要注册平台, [Tumblr 开发者主页](https://www.tumblr.com/developers), [注册应用主页](https://dev.flurry.com/admin/applications), Tumblr SDK **支持 pod 集成**, [分享接口调用说明](https://developer.yahoo.com/flurry/docs/tumblrsharing/iOS/).

#### 集成
a. pod 集成: ``pod 'Flurry-iOS-SDK/TumblrAPI'``
⚠️: 一定是这个, 最新版本的 SDK 我没有找到分享的接口.

b. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.



#### 接口调用

**a. 初始化 SDK**


```swift
RTumblrManager.shared.sdkInitialize(consumerKey: yourConsumerKey, consumerSecret: yourConsumerSecret)
```


**b. 分享**

**文字分享:**

```swift
RTumblrManager.shared.share(text: text, title: title, webpageURL: webpageURL, from: context, completion: completion)
```



**图片链接分享:**


```swift
RTumblrManager.shared.share(imageURL: targetImageURL, description: description, webpageURL: webpageURL, from: context, completion: completion)
```


### Pinterest
#### 准备
分享需要注册平台, [Pinterest 开发者主页](https://developers.pinterest.com/), [注册应用主页](https://developers.pinterest.com/apps/), Pinterest SDK **支持 pod 集成**, [接口调用说明](https://developers.pinterest.com/docs/sdks/ios/).

#### 集成
a. pod 集成: ``pod “PinterestSDK”, :git => “git@github.com:pinterest/ios-pdk.git”``

d. 在 ``info.plist`` 文件的 ``CFBundleURLTypes`` 中添加:

```objc
<key>CFBundleURLTypes</key>
  <array>
    <dict>
      <key>CFBundleURLName</key>
      <string></string>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>pdkYOURAPPID</string>
      </array>
    </dict>
  </array>
```
e. 添加以下至白名单:

```objc
<string>pinterestsdk.v1</string>
```

b. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.



#### 接口调用

**a. 初始化 SDK**

```swift
RPinterestManager.shared.sdkInitialize(appID: yourAppID, appSecret: yourAppSecret)
```


**b. 分享**

**图片链接分享:**


```swift
RPinterestManager.shared.share(imageURL: targetImageURL, webpageURL: webpageURL, boardName: boardName, description: description, from: context, completion: completion)
```


**c. 返回本应用**


```swift
RPinterestManager.application(app, open: url, options : options)
```


### Line
#### 准备
分享无需注册平台.


#### 配置

在``info.plist``文件中:
添加以下至白名单:

```objc
<string>line</string>
```

#### 接口调用

**分享**

**文字分享:**
 

```swift
RLineManager.shared.share(text: text)
```


**图片分享:**

```swift
RLineManager.shared.share(image: targetImage)
```


### WhatsApp
#### 准备
分享无需注册平台.


#### 配置

在``info.plist``文件中:
添加以下至白名单:

```objc
<string>whatsapp</string
```
#### 接口调用

**分享**

**文字分享:**

```swfit
RWhatsAppManager.shared.share(text: text)
```


**图片分享:**

```swift
RWhatsAppManager.shared.share(image: targetImage , from: context)
```




### GooglePlus
#### 准备
分享无需注册平台, [Google Plus 开发者主页](https://developers.google.com/+/)已经把 iOS 相关移除了.

#### 接口调用

**分享**

**网页分享:**

```swift
RGooglePlusManager.shared.share(webpageURL: URL(string: targetURL)!, from: context)
```



## 统一分享接口


### 类
![iOS 分享统一接口类图](https://lh3.googleusercontent.com/-qS7DNoxlpi0/W4YRwCQ7qhI/AAAAAAAAATw/2KMok4xcqTg-qLFtY9V9h9xV8ys8jf9sgCHMYCw/I/iOS%2B)


- **RShareManger:** 主分享 Manager, 子平台 Manager 的初始化、分享、应用跳转和一些其他操作都在此进行;
- **RPlatform:** 主要进行应用是否安装、添加目标应用的操作;
- **RRegister:** 主要进行 ``RShareManager`` 和子平台分享 Manager 的 SDK 初始化衔接;
- **RImageContent、RVideoContent、RTextContent、RWebpageContent** 为四种对应分享内容模型.



### 接口调用

**添加平台及初始化需要注册的平台:**

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let platform = RPlatform.make { (builder) in
        builder.add(p: .Facebook)
        builder.add(p: .Twitter)
        builder.add(p: .QQ)
        builder.add(p: .Wechat)
        builder.add(p: .Instagram)
        builder.add(p: .Tumblr)
        builder.add(p: .Pinterest)
        builder.add(p: .Sina)
        builder.add(p: .GooglePlus)
        builder.add(p: .Line)
        builder.add(p: .WhatsApp)       
            
    }
    RShareManager.shared.registerPlatform(platform: platform) { (p, obj) in
        switch p {
            case .Facebook:
                obj.connectFacebook(appID: yourAppID, secret: nil)
            case .Pinterest:
                obj.connectPinterest(appID: yourAppID, secret: nil)
            case .QQ:
                obj.connectQQ(appID: yourAppID, key: yourKey)
            case .Sina:
                obj.connectSinaWeibo(appKey: yourKey, secret: yourSecret)
            case .Wechat:
                obj.connectWechat(appID: yourAppID, secret: yourSecret)
            case .Tumblr:
                obj.connectTumblr(consumerKey: yourKey, secret: yourSecret)
            case .Twitter:
                obj.connectTwitter(consumerKey: yourKey, secret: yourSecret)
            default : break
        }
    }

        return true
}
```
**构建分享模型:**

以 ``RImageContent`` 为例:


```swift
RImageContent.make { (builder) in
    // ...    
}
```

**分享：**

以分享 ``RImageContent`` 为例:


```swift
RShareManager.shared.shareImage(content: content, channel: channel, from: context) { (platform, result, errorInfo in
    // ...    
}   
```

**返回本应用:**

```swift
RShareManager.shared.application(app, open: url, options : options)   
```

