//
//  VersionView.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 20/01/17.
//  Copyright © 2017 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import Cartography

class VersionView: UIView {
    
    let imageView: UIImageView
    let version: UILabel
    
    init() {
        version = UILabel()
        imageView = UIImageView(image: UIImage(named: "info"))
        
        super.init(frame: CGRect.zero)
        self.initViews()
        self.setupConstraints()
    }
    
    func initViews() {
        version.textColor = .black
        version.text = "Belém delivery v3.0"
        
        addSubview(imageView)
        addSubview(version)
        
        clipsToBounds = true
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        constrain(imageView, self) { imageView, view in
            imageView.left == view.left
            imageView.right == view.right
            imageView.bottom == view.bottom
            imageView.height == 186
            imageView.width == 186
        }
        
        constrain(version, imageView, self) {label, imageView, view in
            label.centerX == view.centerX
            label.top == view.top
            label.bottom == imageView.top
            label.height == 21
        }
        
    }
    
}
