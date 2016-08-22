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
    
    var selectedCompany: NSIndexPath!
    
    func getCompanyForIndexPath(indexPath: NSIndexPath) -> Company {
        return self.companies[indexPath.row]
    }
    
    func getSelectedCompany() -> Company {
        return getCompanyForIndexPath(selectedCompany!)
    }
    
    func count() -> Int {
        return self.companies.count
    }
    
    func load(completion: (result: Bool) -> Void) {
        self.companies = CompanyDataHandler.sharedInstance.getFavorites()
        completion(result: true)
    }
    
    func removeSelectedCompany() {
        let company = getCompanyForIndexPath(selectedCompany!)
        CompanyDataHandler.sharedInstance.removeFromFavorite(company)
        self.companies.removeAtIndex(selectedCompany!.row)
    }
    
    func selectCompanyAtIndexPath(indexPath: NSIndexPath) {
        selectedCompany = indexPath
    }
    
    func getSelectedIndex() -> NSIndexPath {
        return selectedCompany
    }
    
    func getFavoriteTitle() -> String {
        return NSLocalizedString("remove_from_favorite", comment: "")
    }
    
    func getFavoriteImageName() -> String {
        return "removeFavoritos"
    }
}