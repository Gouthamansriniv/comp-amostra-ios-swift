//
//  CompanyCell.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/3/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import Cartography

class CompanyCell: UITableViewCell {

    let labelName: UILabel
    let labelCategory: UILabel
    let companyImage: UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.labelName = UILabel()
        self.labelCategory = UILabel()
        self.companyImage = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        labelName.textColor = .black
        labelName.font = UIFont.systemFont(ofSize: 17.0)
        
        labelCategory.textColor = .gray
        labelCategory.font = UIFont.systemFont(ofSize: 13.0)
        
        companyImage.clipsToBounds = true
        companyImage.layer.borderWidth = 1.0
        companyImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        companyImage.layer.cornerRadius = companyImage.frame.size.width / 2
    }
    
    func addViews() {
        self.addSubview(labelName)
        self.addSubview(labelCategory)
        self.addSubview(companyImage)
    }
    
    func setupConstraints() {
        
        constrain(companyImage, self) { imageView, view in
            imageView.top == view.top + 10
            imageView.left == view.left + 16
            imageView.width == 40
            imageView.height == 40
        }

        constrain(labelName, companyImage, self) { label, imageView, view in
            label.top == imageView.top
            label.left == imageView.right + 8
            label.right == view.right
            label.height == 21
        }

        constrain(labelName, labelCategory, companyImage, self) { name, category, imageView, view in
            category.top == name.bottom + 4
            category.left == imageView.right + 8
            category.right == view.right
            category.height == 21
        }
    }
}
