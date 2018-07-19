//
//  RTwitterAuthHepler.swift
//  share
//
//  Created by valenti on 2018/7/19.
//  Copyright © 2018 rex. All rights reserved.
//

import UIKit

enum RTWAuthState {
    case Success
    case Failure
}
typealias RTWAuthCompletion = (_ state : RTWAuthState,_ errorInfo : String?) -> Void

class RTwitterAuthHepler: NSObject {
    
    static let  shared = RTwitterAuthHepler()
    private override init() {}
    
    
    var hasLogged : Bool  {
        return TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()
    }
    
    func authorizeTwitter(completion : @escaping RTWAuthCompletion) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if (session != nil && !(session?.userID.isEmpty)!) {
                completion(.Success , nil)
            } else {
                completion(.Failure, error?.localizedDescription)
            }
        }
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options : options)
    }

}
