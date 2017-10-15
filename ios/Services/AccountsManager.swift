//
//  AccountsManager.swift
//  ios
//
//  Created by JO10X on 10/15/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import Foundation

class AccountsManager {
    
    class var sharedInstance: AccountsManager {
        struct Static {
            static let instance: AccountsManager = AccountsManager()
        }
        return Static.instance
    }
    
    private var _accounts: [String]
    var accounts: [String] {
        get { return _accounts }
    }
    
    init() {
        if let accList = UserDefaults.standard.object(forKey: ACCOUNTS_LIST) as? [String] {
            _accounts = accList
        } else {
            _accounts = ["apple"]
        }
    }
    
    func addAccount(username: String) {
        _accounts.append(username)
        save()
    }
    
    func removeAccount(username: String) {
        guard username != "apple" else { return }
        _accounts = _accounts.filter { $0 != username }
        save()
    }
    
    fileprivate func save() {
        UserDefaults.standard.set(_accounts, forKey: ACCOUNTS_LIST)
    }
    
}
