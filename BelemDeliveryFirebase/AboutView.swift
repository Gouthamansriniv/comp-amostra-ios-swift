//
//  AboutView.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 20/01/17.
//  Copyright © 2017 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import Cartography

class AboutView: UIView {
    
    let topView: TopView
    let versionView: VersionView
    let poweredByView: PoweredByView
    
    let containerView = UIView()
    
    let scrollView = UIScrollView()
    
    init() {

        topView = TopView(title: NSLocalizedString("about", comment: ""))
        versionView = VersionView()
        poweredByView = PoweredByView()
        
        super.init(frame: CGRect.zero)
        self.initViews()
        self.setupConstraints()
    }
    
    func initViews() {
        self.backgroundColor = .white
        
        addSubview(topView)
        
        containerView.addSubview(versionView)
        containerView.addSubview(poweredByView)
        
        containerView.clipsToBounds = true

        scrollView.addSubview(containerView)
        
        addSubview(scrollView)
        containerView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        constrain(topView, self) { topView, view in
            topView.top == view.top
            topView.right == view.right
            topView.left == view.left
            topView.height == 64
        }
        
        constrain(scrollView, containerView) {scrollView, containerView in
            containerView.top == scrollView.top + 20
            containerView.bottom <= scrollView.bottom - 20
            containerView.left == scrollView.left
            containerView.right == scrollView.right
        }
        
        constrain(topView, scrollView, self) {topView, scrollView, view in
            scrollView.top == topView.bottom
            scrollView.left == topView.left
            scrollView.right == topView.right
            scrollView.bottom == view.bottom
        }
        
        constrain(containerView, self, poweredByView, versionView) {container, view, poweredByView, versionView in
            container.centerX == view.centerX
            
            container.top == versionView.top    
            container.bottom == poweredByView.bottom
            
            container.right >= poweredByView.right
            container.right >= versionView.right
            
            container.left <= poweredByView.left
            container.left <= versionView.left
            
            versionView.bottom == poweredByView.top - 10
            versionView.centerX == container.centerX
            poweredByView.centerX == container.centerX
        }
    }
}
