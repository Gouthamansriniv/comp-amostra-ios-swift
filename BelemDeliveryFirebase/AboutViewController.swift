//
//  AboutViewController.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var customTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        customTitle.text = NSLocalizedString("about", comment: "")
    }
    
}

