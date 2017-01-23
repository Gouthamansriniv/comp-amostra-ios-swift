//
//  TopView.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 20/01/17.
//  Copyright © 2017 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import Cartography

class TopView: UIView {
 
    let title: UILabel
    
    init(title: String) {
        self.title = UILabel()
        self.title.text = title
        super.init(frame: CGRect.zero)
        self.initViews()
        self.setupConstraints()
    }
    
    func initViews() {
        title.textColor = .white
        backgroundColor = UIColor.init(netHex: 0xDF343D)
        
        clipsToBounds = true
        
        addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        constrain(title, self) { label, view in
            label.centerX == view.centerX
            label.centerY == view.centerY + 10
        }
        
    }
    
}
