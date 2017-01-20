//
//  FirebaseLogger.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/16/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Firebase

class FirebaseLogger: NSObject {
    
    static let sharedInstance = FirebaseLogger()
    
    fileprivate override init() {
        super.init()
        
        if let user = FIRAuth.auth()?.currentUser {
            FIRAnalytics.setUserID(user.uid)
        }
    }
    
    func log(_ object : [String: String], name: String) {
        var object = object
        if let user = FIRAuth.auth()?.currentUser {
            object["user"] = user.uid
                FIRAnalytics.setUserID(user.uid)
        }
        
        FIRAnalytics.logEvent(withName: name, parameters: object as [String : NSObject]?)
    }
    
}
