//
//  FavoriteViewController.swift
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

class FavoriteViewController: ListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = FavoriteViewModel()
        getList()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getList()
    }
    
    func getList() {
        self.viewModel.load { (result) in
            if(result) {
                self.companyTable.reloadData()
            }
        }
    }
    
    override func favoritesTouch() {
        self.viewModel.removeSelectedCompany()
        companyTable.beginUpdates()
        companyTable.deleteRowsAtIndexPaths([viewModel.getSelectedIndex()], withRowAnimation: .Top)
        companyTable.endUpdates()
    }
}
