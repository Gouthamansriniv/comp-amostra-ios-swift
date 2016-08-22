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
import CarbonKit
import Firebase

extension CompanyViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class CompanyViewController: ListViewController, CarbonObserver  {
    
    var refresh: CarbonSwipeRefresh!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCarbonSwipe()
        self.viewModel = CompanyViewModel()
        self.initSearchController()
        getList()
    }
    
    func initCarbonSwipe() {
        self.refresh = CarbonSwipeRefresh.init(scrollView: self.companyTable)
        self.view.addSubview(self.refresh)
        self.refresh.colors = [
            UIColor(netHex: ColorPicker.sharedInstance.getColor())
        ]
        self.refresh.addTarget(self, action: #selector(getList), forControlEvents: .ValueChanged)
    }
    
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor(netHex: ColorPicker.sharedInstance.getColor())
        searchController.searchBar.barTintColor = UIColor.whiteColor()
        searchController.searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
        definesPresentationContext = true
        companyTable.tableHeaderView = searchController.searchBar
    }
    
    func willChangeTabs() {
        self.searchController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
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
        self.refresh?.startRefreshing()
        
        self.viewModel.load { (result) in
            if result {
                self.companyTable.reloadData()
                self.refresh?.endRefreshing()
            }
        }
    }
    
}