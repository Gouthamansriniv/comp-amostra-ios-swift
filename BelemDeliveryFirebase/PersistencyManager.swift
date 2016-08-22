//
//  PersistencyManager.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Gloss
import RealmSwift

class PersistencyManager: NSObject {
    
//    let filepath = (NSHomeDirectory().stringByAppendingString("/Documents/companies.bin"))
    
    override init() {
        super.init()
    }
    
    func get() -> [Company] {
        
//        if let companies = NSKeyedUnarchiver.unarchiveObjectWithFile(filepath) as? JSON {
//            let response = CompanyResponse(json : companies)
//            return response!.companies!
//        }
//        
//        return []

        var companies:[Company] = []
        
        let realm = try! Realm()
        let realmCompanies = realm.objects(RealmCompany.self)
        
        for company in realmCompanies {
            companies.append((company.toGlossy()))
        }
        
        return companies
    
    }
    
    func getFavorites() -> [Company] {
        
        var companies:[Company] = []
        
        let realm = try! Realm()
        let realmFavorites = realm.objects(RealmFavorite.self)
        
        for company in realmFavorites {
            companies.append((company.favorite?.toGlossy())!)
        }
        
        return companies
    }
    
    func save(companies : CompanyResponse) {
//        let data = NSKeyedArchiver.archivedDataWithRootObject(companies.toJSON()!)
//        data.writeToFile(filepath, atomically: false)
        
        let realm = try! Realm()
        try! realm.write() {
            for company in companies.companies! {
                realm.add(company.toRealm(), update: true)
            }
        }
    }
    
    func addToFavorite(company: Company) {
        let realm = try! Realm()
        try! realm.write() {
            let favorite = RealmFavorite()
            favorite.favorite = company.toRealm()
            favorite.id = company.id
            realm.add(favorite, update: true)
        }
    }
    
    func removeFromFavorite(company: Company) {
        let realm = try! Realm()
        try! realm.write() {
            if let favorite = realm.objectForPrimaryKey(RealmFavorite.self, key: company.id) {
                realm.delete(favorite)
            }
        }
    }
    
}
