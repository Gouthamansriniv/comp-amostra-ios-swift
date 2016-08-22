//
//  RealmCompany.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/12/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import RealmSwift

class RealmCompany : Object {
    
    dynamic var id : String? = ""
    dynamic var name: String? = ""
    dynamic var image: String? = ""
    dynamic var category: String? = ""
    let phones: List<RealmPhone> = List()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toGlossy() -> Company {
        
        var company = Company()
        company.id = self.id
        company.name = self.name
        company.image = self.image
        company.category = self.category
        
        for number in self.phones {
            company.phones?.append(number.phone!)
        }
        
        return company
    }
    
}