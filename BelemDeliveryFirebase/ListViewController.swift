//
//  ListViewController.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/17/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import CZPicker
import SDWebImage

extension ListViewController: CZPickerViewDelegate, CZPickerViewDataSource {
    func czpickerView(pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        
        let company = viewModel.getSelectedCompany()
        
        if(row == (company.phones?.count)!) {
            return UIImage(named: viewModel.getFavoriteImageName())
        }
        
        return UIImage(named: "call")
    }
    
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        let company = viewModel.getSelectedCompany()
        
        return company.phones!.count + 1
    }
    
    func czpickerView(pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        
        let company = viewModel.getSelectedCompany()
        
        if(company.phones == nil) {
            return ""
        }
        
        if(row == (company.phones?.count)!) {
            return viewModel.getFavoriteTitle()
        }
        
        return company.phones![row]
    }
    
    func czpickerView(pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        
        
        let company = viewModel.getSelectedCompany()
        
        if(row == company.phones!.count) {
            favoritesTouch()
        } else {
            let phone = "tel://"+company.phones![row].stringByReplacingOccurrencesOfString("-", withString: "")
            let URL = NSURL(string: phone)!
            if(UIApplication.sharedApplication().canOpenURL(URL)) {
                
                let parameters = [
                    "establishment": company.name!,
                    "number": company.phones![row],
                    "category": company.category!
                ]
                
                FirebaseLogger.sharedInstance.log(parameters, name: "call")
                UIApplication.sharedApplication().openURL(URL)
            }
        }
    }

}

extension ListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("company") as! CompanyCell
        
        let company = viewModel.getCompanyForIndexPath(indexPath)
        
        cell.labelName.text = company.name
        cell.labelCategory.text = company.category
        cell.companyImage.sd_setImageWithURL(NSURL(string: company.image!))
        cell.companyImage.layer.cornerRadius = cell.companyImage.frame.size.width / 2
        cell.companyImage.clipsToBounds = true
        cell.companyImage.layer.borderWidth = 1.0
        cell.companyImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        viewModel.selectCompanyAtIndexPath(indexPath)
        let company = viewModel.getSelectedCompany()
        
        let picker = CZPickerView.init(headerTitle: company.name, cancelButtonTitle: NSLocalizedString("cancel", comment: ""), confirmButtonTitle: NSLocalizedString("call", comment: ""))
        picker.needFooterView = false
        picker.headerBackgroundColor = UIColor(netHex: ColorPicker.sharedInstance.getColor())
        picker.confirmButtonBackgroundColor = UIColor(netHex: ColorPicker.sharedInstance.getColor())
        picker.delegate = self;
        picker.dataSource = self;
        
        picker.show()
    }
}

class ListViewController: UIViewController {
    
    @IBOutlet weak var companyTable: UITableView!
    
    var viewModel: ListViewModel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.companyTable.registerNib(UINib(nibName: "CompanyCell", bundle: nil), forCellReuseIdentifier: "company")
        self.companyTable.registerNib(UINib(nibName: "CompanyHeaderCell", bundle: nil), forCellReuseIdentifier: "header")
    }
    
    func favoritesTouch() {
        
    }
}
