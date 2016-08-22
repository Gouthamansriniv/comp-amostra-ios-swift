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
    
    private override init() {
        super.init()
        
        if let user = FIRAuth.auth()?.currentUser {
            FIRAnalytics.setUserID(user.uid)
        }
    }
    
    func log(object : [String: String], name: String) {
        var object = object
        if let user = FIRAuth.auth()?.currentUser {
            object["user"] = user.uid
                FIRAnalytics.setUserID(user.uid)
        }
        
        FIRAnalytics.logEventWithName(name, parameters: object)
    }
    
}
