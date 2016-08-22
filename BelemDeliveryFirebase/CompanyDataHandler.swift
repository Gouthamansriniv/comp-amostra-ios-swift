//
//  CompanyDataHandler.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Alamofire
import Gloss
import CoreSpotlight

class CompanyDataHandler: NSObject {
    
    static let sharedInstance = CompanyDataHandler()
    var persistencyManager: PersistencyManager!
    let isOnline: Bool = true
    
    private override init() {
        super.init()
        persistencyManager = PersistencyManager.init()
    }
    
    func getCompanies(completion: (result: [Company]) -> Void) {
        
        if(isOnline) {
            Alamofire.request(.GET, "http://www.fctradecenter.com/delivery/api/company", parameters: nil)
                .responseJSON { response in
                    
                    switch response.result {
                        
                    case .Success(let json):
                        let companies = CompanyResponse(json : json as! JSON)
                        
                        self.persistencyManager.save(companies!)
                        //self.processCompany(companies!.companies!)
                        //completion(result: companies!.companies!)
                        
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                        
                        completion(result: self.persistencyManager.get())
                    }
            }
        } else {
            completion(result: self.persistencyManager.get())
        }
    }
    
    func processCompany(companies: [Company]) -> [String:[Company]] {
        var dic = [String:[Company]]()
        
        var keys = [String]()
        
        for company in companies {
            if let letter = company.name!.characters.first {
                if(!keys.contains(String(letter))) {
                    keys.append(String(letter))
                }
            }
            
        }
        
        for key in keys {
            dic[key] = companies.filter() {company in (
                    (company.name?.lowercaseString.hasPrefix(key.lowercaseString))!)}
        }
        
        return dic
    }
    
    func getFavorites() -> [Company] {
        return self.persistencyManager.getFavorites()
    }
    
    func addToFavorite(company: Company) {
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([company.item], completionHandler: nil)
        
        self.persistencyManager.addToFavorite(company)
    }
    
    func removeFromFavorite(company: Company) {
        
        CSSearchableIndex
            .defaultSearchableIndex()
            .deleteSearchableItemsWithIdentifiers([company.id!], completionHandler: nil)
        
        self.persistencyManager.removeFromFavorite(company)
    }
    
}
