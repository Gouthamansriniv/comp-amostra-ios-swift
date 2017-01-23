//
//  PoweredByView.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 20/01/17.
//  Copyright © 2017 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import Cartography

class PoweredByView: UIView {
    
    let imageView: UIImageView
    let version: UILabel
    
    init() {
        version = UILabel()
        imageView = UIImageView(image: UIImage(named: "onhands"))
        
        super.init(frame: CGRect.zero)
        self.initViews()
        self.setupConstraints()
    }
    
    func initViews() {
        version.textColor = .black
        version.text = "Desenvolvido por:"
        
        imageView.contentMode = .scaleToFill
        
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
            imageView.height == 69
            imageView.bottom == view.bottom
            imageView.width == 216
            imageView.centerX == view.centerX
        }
        
        constrain(version, imageView, self) {label, imageView, view in
            label.centerX == view.centerX
            label.top == view.top
            label.bottom == imageView.top
            label.height == 21
            
            view.left >= label.left
            view.left >= imageView.left
            
            view.right >= label.right
            view.right >= imageView.right
        }
        
    }
    
}
