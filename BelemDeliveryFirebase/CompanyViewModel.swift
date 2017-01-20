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
    
    var selectedCompany: IndexPath!
    
    func getCompanyForIndexPath(_ indexPath: IndexPath) -> Company {
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
    
    func filterBy(_ searchText: String) {
        
        if (searchText == "") { isActive = false } else { isActive = true}
        
        self.companiesFilter = self.companies.filter(){company in (
            (company.name?.lowercased().contains(searchText.lowercased()))! ||
                (company.category?.lowercased().contains(searchText.lowercased()))!
            )}
    }
    
    func load(_ completion: @escaping (_ result: Bool) -> Void) {
        CompanyDataHandler.sharedInstance.getCompanies { (result) in
    
            if(result.count > 0) {
                self.companies = result
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getFavoriteImageName() -> String {
        return "addFavoritos"
    }
    
    func getFavoriteTitle() -> String {
        return NSLocalizedString("add_to_favorite", comment: "")
    }
    
    func selectCompanyAtIndexPath(_ indexPath: IndexPath) {
        selectedCompany = indexPath
    }
    
    func getSelectedIndex() -> IndexPath {
        return selectedCompany
    }
    
    func removeSelectedCompany() {
        let company = getSelectedCompany()
        CompanyDataHandler.sharedInstance.removeFromFavorite(company)
        self.companies.remove(at: selectedCompany!.row)
    }
    
    func isActive(_ isActive: Bool) {
        self.isActive = isActive
    }
}
