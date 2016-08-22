//
//  Protocol.swift
//  BelemDeliveryFirebase
//
//  Created by Rodrigo Cavalcante on 8/17/16.
//  Copyright © 2016 Rodrigo Cavalcante. All rights reserved.
//
import Foundation

protocol ListViewModel {
    func getFavoriteTitle() -> String
    func getFavoriteImageName() -> String
    func getCompanyForIndexPath(indexPath: NSIndexPath) -> Company
    func getSelectedCompany() -> Company
    func count() -> Int
    func load(completion: (result: Bool) -> Void)
    func removeSelectedCompany()
    func selectCompanyAtIndexPath(indexPath: NSIndexPath)
    func getSelectedIndex() -> NSIndexPath
}