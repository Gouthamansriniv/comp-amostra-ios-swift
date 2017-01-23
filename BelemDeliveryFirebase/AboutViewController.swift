//
//  AboutViewController.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import Cartography
import UIKit

class AboutViewController: UIViewController {

    let container = AboutView()

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.image = UIImage(named: "sobre")
        self.container.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = container
    }
    
}

