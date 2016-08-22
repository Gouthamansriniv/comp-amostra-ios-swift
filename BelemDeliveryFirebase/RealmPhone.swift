//
//  RealmPhone.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/12/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import RealmSwift

class RealmPhone : Object {
    
    dynamic var phone : String? = ""
    
    override static func primaryKey() -> String? {
        return "phone"
    }
}
