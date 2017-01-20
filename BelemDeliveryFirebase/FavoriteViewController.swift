//
//  FavoriteViewController.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit

class FavoriteViewController: ListViewController {
    
    @IBOutlet weak var customTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = FavoriteViewModel()
        customTitle.text = NSLocalizedString("favorites", comment: "")
        getList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        companyTable.deleteRows(at: [viewModel.getSelectedIndex() as IndexPath], with: .top)
        companyTable.endUpdates()
    }
}
