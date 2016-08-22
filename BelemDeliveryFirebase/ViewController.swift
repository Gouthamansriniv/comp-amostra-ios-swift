//
//  ViewController.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/2/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import CarbonKit
import TextFieldEffects
import Firebase

protocol CarbonObserver : class {
    func willChangeTabs()
}

extension ViewController: CarbonTabSwipeNavigationDelegate {
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAtIndex index: UInt) {
        
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAtIndex index: UInt) {
        self.notify()
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        var viewController: UIViewController
        
        switch index {
        case 0:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("CompanyViewController") as! CompanyViewController
            self.observers.append(viewController as! CompanyViewController)
            
        case 1:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("FavoriteViewController") as! FavoriteViewController
            
        case 2:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
            
        default:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("CompanyViewController") as! CompanyViewController
        }
        
        return viewController
    }
    
    func notify() {
        for observer in self.observers {
            observer.willChangeTabs()
        }
    }

}

class ViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var centerView: UIView!
    
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation!
    var observers = [CarbonObserver]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.signInAnonymouslyWithCompletion(nil)
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initCarbonNavigation()
        self.topView.backgroundColor = UIColor(netHex: ColorPicker.sharedInstance.getColor())
    }
    
    func initCarbonNavigation() {
        
        let tabs: [AnyObject] = [
            UIImage(named:"estabelecimento")!,
            UIImage(named:"favoritos")!,
            UIImage(named:"sobre")!
        ]
        
        self.carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: tabs, delegate: self)
        self.carbonTabSwipeNavigation.insertIntoRootViewController(self, andTargetView: self.centerView)
        self.carbonTabSwipeNavigation.setIndicatorColor(UIColor(netHex: ColorPicker.sharedInstance.getColor()))
        self.carbonTabSwipeNavigation.setSelectedColor(UIColor(netHex: ColorPicker.sharedInstance.getColor()))
        self.carbonTabSwipeNavigation.toolbar.translucent = false;
        self.carbonTabSwipeNavigation.setNormalColor(UIColor.lightGrayColor())
        self.carbonTabSwipeNavigation.setTabExtraWidth(self.view.frame.size.height/9)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setShadow(layer : CALayer) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSizeMake(1, 1)
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.30
        layer.shadowPath = UIBezierPath.init(rect: layer.bounds).CGPath
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setShadow(self.topView.layer)
    }
}

