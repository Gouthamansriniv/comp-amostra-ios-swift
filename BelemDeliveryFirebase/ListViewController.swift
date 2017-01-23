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
import Cartography

extension ListViewController: CZPickerViewDelegate, CZPickerViewDataSource {
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        
        let company = viewModel.getSelectedCompany()
        
        if(row == (company.phones?.count)!) {
            return UIImage(named: viewModel.getFavoriteImageName())
        }
        
        return UIImage(named: "call")
    }
    
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        let company = viewModel.getSelectedCompany()
        
        return company.phones!.count + 1
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        
        let company = viewModel.getSelectedCompany()
        
        if(company.phones == nil) {
            return ""
        }
        
        if(row == (company.phones?.count)!) {
            return viewModel.getFavoriteTitle()
        }
        
        return company.phones![row]
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        
        
        let company = viewModel.getSelectedCompany()
        
        if(row == company.phones!.count) {
            favoritesTouch()
        } else {
            let phone = "tel://"+company.phones![row].replacingOccurrences(of: "-", with: "")
            let URL = Foundation.URL(string: phone)!
            if(UIApplication.shared.canOpenURL(URL)) {
                
                let parameters = [
                    "establishment": company.name!,
                    "number": company.phones![row],
                    "category": company.category!
                ]
                
                FirebaseLogger.sharedInstance.log(parameters, name: "call")
                UIApplication.shared.openURL(URL)
            }
        }
    }

}

extension ListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "company") as? CompanyCell else {
            return UITableViewCell()
        }
        
        let company = viewModel.getCompanyForIndexPath(indexPath)
        
        cell.labelName.text = company.name
        cell.labelCategory.text = company.category
        cell.companyImage.sd_setImage(with: URL(string: company.image!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        viewModel.selectCompanyAtIndexPath(indexPath)
        let company = viewModel.getSelectedCompany()
        
        let picker = CZPickerView.init(headerTitle: company.name, cancelButtonTitle: NSLocalizedString("cancel", comment: ""), confirmButtonTitle: NSLocalizedString("call", comment: ""))
        picker?.needFooterView = false
        picker?.headerBackgroundColor = UIColor(netHex: 0xDF343D)
        picker?.confirmButtonBackgroundColor = UIColor(netHex: 0xDF343D)
        picker?.delegate = self;
        picker?.dataSource = self;
        
        picker?.show()
    }
}

class ListViewController: UIViewController {
    
    let topView: TopView
    var viewModel: ListViewModel
    let tableView: UITableView
    
    let containerView = UIView()
    
    init(viewModel: ListViewModel, title: String) {
        self.viewModel = viewModel
        topView = TopView(title: title)
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        
        super.init(nibName: nil, bundle: nil)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.backgroundColor = .white
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        
        containerView.addSubview(topView)
        containerView.addSubview(tableView)
        
        setupConstraints()
        containerView.translatesAutoresizingMaskIntoConstraints = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.tableView.register(CompanyCell.self, forCellReuseIdentifier: "company")
    }
    
    override func loadView() {
        self.view = containerView
    }
    
    func favoritesTouch() {
        
    }
    
    func setupConstraints() {
        constrain(topView, tableView, containerView) { topView, tableView, containerView in
            topView.top == containerView.top
            topView.left == containerView.left
            topView.right == containerView.right
            topView.height == 64
            
            tableView.top == topView.bottom
            tableView.left == containerView.left
            tableView.right == containerView.right
            tableView.bottom == containerView.bottom
        }
    }
}
