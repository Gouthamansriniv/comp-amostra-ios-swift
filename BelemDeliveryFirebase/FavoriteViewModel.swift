//
//  FavoriteViewModel.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/17/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Foundation

class FavoriteViewModel: ListViewModel {
    
    var companies = [Company]()
    var companiesFilter = [Company]()
    
    var selectedCompany: IndexPath!
    
    func getCompanyForIndexPath(_ indexPath: IndexPath) -> Company {
        return self.companies[indexPath.row]
    }
    
    func getSelectedCompany() -> Company {
        return getCompanyForIndexPath(selectedCompany!)
    }
    
    func count() -> Int {
        return self.companies.count
    }
    
    func load(_ completion: @escaping (_ result: Bool) -> Void) {
        self.companies = CompanyDataHandler.sharedInstance.getFavorites()
        completion(true)
    }
    
    func removeSelectedCompany() {
        let company = getCompanyForIndexPath(selectedCompany!)
        CompanyDataHandler.sharedInstance.removeFromFavorite(company)
        self.companies.remove(at: selectedCompany!.row)
    }
    
    func selectCompanyAtIndexPath(_ indexPath: IndexPath) {
        selectedCompany = indexPath
    }
    
    func getSelectedIndex() -> IndexPath {
        return selectedCompany
    }
    
    func getFavoriteTitle() -> String {
        return NSLocalizedString("remove_from_favorite", comment: "")
    }
    
    func getFavoriteImageName() -> String {
        return "removeFavoritos"
    }
}
