//
//  Company.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Foundation
import Gloss
import CoreSpotlight
import MobileCoreServices

extension Company {
    public static let domainIdentifier = "com.onhands.belemdelivery.company"
    
    public var item: CSSearchableItem {
        let item = CSSearchableItem.init(uniqueIdentifier: id, domainIdentifier: Company.domainIdentifier, attributeSet: attributeSet
        )
        
        return item
    }
    
    public var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeContact as String)
        attributeSet.title = name
        
        if let c = category {
            attributeSet.contentDescription = "\(c)\nSalvo nos favoritos"
        }
        
        attributeSet.supportsPhoneCall = true
        attributeSet.phoneNumbers = phones
        
        if let n = name {
            attributeSet.keywords = [n]
        }
        
        
        return attributeSet
    }
}

public struct Company : Glossy {
    
    var id : String?
    var name: String?
    var image: String?
    var category: String?
    var phones: [String]?
    
    init() {
        self.id = ""
        self.name = ""
        self.image = ""
        self.category = ""
        self.phones = []
    }
    
    public init?(json: JSON) {
        //self.id = Decoder.decode("id")(json)
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.image = "image" <~~ json
        self.category = "category" <~~ json
        self.phones = "phones" <~~ json
    }
    
    public func toJSON() -> JSON? {
        return jsonify([
            //Encoder.encode("id")(self.id),
            "id" ~~> self.id,
            "name" ~~> self.name,
            "image" ~~> self.image,
            "category" ~~> self.category,
            "phones" ~~> self.phones
            ])
    }
    
    func toRealm() -> RealmCompany {
        let realm = RealmCompany()
        realm.id = self.id
        realm.name = self.name
        realm.category = self.category
        realm.image = self.image
        
        if let p = self.phones {
            for number in p {
                let phone = RealmPhone()
                phone.phone = number
                realm.phones.append(phone)
            }
        }
        
        return realm
    }
}