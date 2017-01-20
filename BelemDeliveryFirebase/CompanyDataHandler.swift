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
    
    fileprivate override init() {
        super.init()
        persistencyManager = PersistencyManager.init()
    }
    
    func getCompanies(_ completion: @escaping (_ result: [Company]) -> Void) {
        if(isOnline) {
            Alamofire.request("http://www.fctradecenter.com/delivery/api/company", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                case .success(let json):
                    let companies = CompanyResponse(json : json as! JSON)
                    
                    self.persistencyManager.save(companies!)
                    self.processCompany(companies!.companies!)
                    completion(companies!.companies!)
                    
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    
                    completion(self.persistencyManager.get())
                }
            })
        } else {
            completion(self.persistencyManager.get())
        }
    }
    
    func processCompany(_ companies: [Company]) -> [String:[Company]] {
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
                (company.name?.lowercased().hasPrefix(key.lowercased()))!)}
        }
        
        return dic
    }
    
    func getFavorites() -> [Company] {
        return self.persistencyManager.getFavorites()
    }
    
    func addToFavorite(_ company: Company) {
        CSSearchableIndex.default().indexSearchableItems([company.item], completionHandler: nil)
        
        self.persistencyManager.addToFavorite(company)
    }
    
    func removeFromFavorite(_ company: Company) {
        
        CSSearchableIndex
            .default()
            .deleteSearchableItems(withIdentifiers: [company.id!], completionHandler: nil)
        
        self.persistencyManager.removeFromFavorite(company)
    }
    
}
