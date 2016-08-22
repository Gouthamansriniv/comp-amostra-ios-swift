//
//  CompanyResponse.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Gloss

struct CompanyResponse : Glossy {
    
    let status: Status?
    var companies: [Company]?
    
    init() {
        status = Status()
        companies = [Company]()
    }
    
    init?(json: JSON) {
        self.status = "status" <~~ json
        self.companies = "companies" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "status" ~~> self.status,
            "companies" ~~> self.companies
            ])
    }
}