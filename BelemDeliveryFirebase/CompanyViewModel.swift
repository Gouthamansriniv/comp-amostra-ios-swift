//
//  CompanyViewModel.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/16/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Foundation

class CompanyViewModel: ListViewModel {
    
    var companies = [Company]()
    var companiesFilter = [Company]()
    
    var isActive: Bool = false
    
    var selectedCompany: NSIndexPath!
    
    func getCompanyForIndexPath(indexPath: NSIndexPath) -> Company {
        var company:Company!
        if isActive {
            company = self.companiesFilter[indexPath.row]
        } else {
            company = self.companies[indexPath.row]
        }
        
        selectedCompany = indexPath
        
        return company
    }
    
    func getSelectedCompany() -> Company {
        return getCompanyForIndexPath(selectedCompany)
    }
    
    func count() -> Int {
        if isActive {
            return self.companiesFilter.count
        } else {
            return self.companies.count
        }
    }
    
    func filterBy(searchText: String) {
        
        if (searchText == "") { isActive = false } else { isActive = true}
        
        self.companiesFilter = self.companies.filter(){company in (
            (company.name?.lowercaseString.containsString(searchText.lowercaseString))! ||
                (company.category?.lowercaseString.containsString(searchText.lowercaseString))!
            )}
    }
    
    func load(completion: (result: Bool) -> Void) {
        CompanyDataHandler.sharedInstance.getCompanies { (result) in
    
            if(result.count > 0) {
                self.companies = result
                completion(result: true)
            } else {
                completion(result: false)
            }
        }
    }
    
    func getFavoriteImageName() -> String {
        return "addFavoritos"
    }
    
    func getFavoriteTitle() -> String {
        return NSLocalizedString("add_to_favorite", comment: "")
    }
    
    func selectCompanyAtIndexPath(indexPath: NSIndexPath) {
        selectedCompany = indexPath
    }
    
    func getSelectedIndex() -> NSIndexPath {
        return selectedCompany
    }
    
    func removeSelectedCompany() {
        let company = getSelectedCompany()
        CompanyDataHandler.sharedInstance.removeFromFavorite(company)
        self.companies.removeAtIndex(selectedCompany!.row)
    }
    
    func isActive(isActive: Bool) {
        self.isActive = isActive
    }
}
