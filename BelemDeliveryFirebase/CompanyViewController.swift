//
//  Companies.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import Realm
import SSSnackbar
import CZPicker
import SDWebImage
import Firebase

extension CompanyViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class CompanyViewController: ListViewController  {
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var customTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CompanyViewModel()
        customTitle.text = NSLocalizedString("establishment", comment: "")
        self.initSearchController()
        getList()
    }
    
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor(netHex: 0xDF343D)
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
        definesPresentationContext = true
        companyTable.tableHeaderView = searchController.searchBar
    }
    
    func willChangeTabs() {
        self.searchController.dismiss(animated: true, completion: nil)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        (self.viewModel as! CompanyViewModel).filterBy(searchText)
        companyTable.reloadData()
    }
    
    override func favoritesTouch() {
        let company = self.viewModel.getSelectedCompany()

        CompanyDataHandler.sharedInstance.addToFavorite(company)
        SSSnackbar.init(message: String(format: NSLocalizedString("added_to_favorite", comment: ""), company.name!), actionText: NSLocalizedString("undo", comment: ""), duration: 5, actionBlock: { (SSSnackbar) in
            CompanyDataHandler.sharedInstance.removeFromFavorite(company)
            }, dismissalBlock: nil).show()
    }
    
    func getList() {
        self.viewModel.load { (result) in
            if result {
                self.companyTable.reloadData()
            }
        }
    }
    
}
