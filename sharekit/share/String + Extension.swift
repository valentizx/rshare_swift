//
//  String + Extension.swift
//  share
//
//  Created by valenti on 2018/8/9.
//  Copyright © 2018 rex. All rights reserved.
//

import Foundation

extension String {
    var extensionName : String {
        get {
            return self.components(separatedBy: ".").last!
        }
    }
    static func randomFileName() -> String {
        let date = Date()
        return "\(date.timeIntervalSince1970)"
        
    }
}
