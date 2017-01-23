//
//  FavoriteViewController.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import Cartography

class FavoriteViewController: ListViewController {
    
    init() {
        super.init(viewModel: FavoriteViewModel(), title: NSLocalizedString("favorites", comment: ""))
        self.tabBarItem.image = UIImage(named: "favoritos")
        self.tableView.rowHeight = 60
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getList()
    }
    
    func getList() {
        self.viewModel.load { (result) in
            if(result) {
                self.tableView.reloadData()
            }
        }
    }
    
    override func favoritesTouch() {
        self.viewModel.removeSelectedCompany()
        tableView.beginUpdates()
        tableView.deleteRows(at: [viewModel.getSelectedIndex() as IndexPath], with: .top)
        tableView.endUpdates()
    }
}
