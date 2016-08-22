//
//  RealmFavorite.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/12/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import RealmSwift

class RealmFavorite : Object {
    
    dynamic var id : String? = ""
    dynamic var favorite: RealmCompany?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
