//
//  AccountsManager.swift
//  ios
//
//  Created by JO10X on 10/15/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import Foundation
import RxSwift

class AccountsManager {
    
    class var sharedInstance: AccountsManager {
        struct Static {
            static let instance: AccountsManager = AccountsManager()
        }
        return Static.instance
    }
    
    private var _accounts: [String]
    private var observable: BehaviorSubject<[String]>
    private let disposeBag = DisposeBag()
    
    var accounts: [String] {
        get { return _accounts }
    }
    
    init() {
        if let accList = UserDefaults.standard.object(forKey: ACCOUNTS_LIST) as? [String] {
            _accounts = accList
        } else {
            _accounts = ["apple"]
        }
        observable = BehaviorSubject(value:_accounts)
    }
    
    func addAccount(username: String) {
        _accounts.append(username)
        save()
        observable.on(.next(_accounts))
    }
    
    func removeAccount(username: String) {
        guard username != "apple" else { return }
        _accounts = _accounts.filter { $0 != username }
        save()
        observable.on(.next(_accounts))
    }
    
    fileprivate func save() {
        UserDefaults.standard.set(_accounts, forKey: ACCOUNTS_LIST)
    }
    
    typealias accountSubscribe = (_ accounts: [String]?) -> Void
    
    func subscribe(on: @escaping accountSubscribe) {
        let disposable = observable.subscribe { (event) in
            on(event.element)
        }
        disposable.disposed(by: disposeBag)
    }

    
}
