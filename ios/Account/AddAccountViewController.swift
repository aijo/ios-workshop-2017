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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Account"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonDidPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
