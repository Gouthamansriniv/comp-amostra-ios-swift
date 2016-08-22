//
//  Status.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Gloss

struct Status : Glossy {
    
    let code : Int?
    let message: String?
    
    init() {
        self.code = 0
        self.message = ""
    }
    
    init?(json: JSON) {
        self.code = "code" <~~ json
        self.message = "message" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "code" ~~> self.code,
            "message" ~~> self.message
            ])
    }
}