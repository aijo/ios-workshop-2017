//
//  AddAccountViewController.swift
//  ios
//
//  Created by JO10X on 10/15/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import UIKit

class AddAccountViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    private let accountManager = AccountsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Account"
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissGesture)
        
        usernameTextfield.delegate = self
        usernameTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        addButton.isEnabled = false
        addButton.setBackgroundColor(color: UIColor.init(rgba: "#2EB0FC"), forState: .normal)
        addButton.setBackgroundColor(color: UIColor.init(rgba: "#EEEEEE"), forState: .disabled)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonDidPressed(_ sender: Any) {
        if let username = usernameTextfield.text {
            accountManager.addAccount(username: username)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}

@objc extension AddAccountViewController: UITextFieldDelegate {
    
    fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    fileprivate func textFieldDidChange(_ textField: UITextField) {
        if let username = usernameTextfield.text {
            addButton.isEnabled = username.characters.count > 0
        }
    }
    
}
