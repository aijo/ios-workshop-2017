//
//  AccountViewController.swift
//  ios
//
//  Created by JO10X on 10/15/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
    
    private let ACCOUNTS_SECTION = 0
    private let LOGOUT_SECTION = 1
    
    private let accountManager = AccountsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Account"
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToAddAccount))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func navigateToAddAccount() {
        self.performSegue(withIdentifier: "gotoAddAccount", sender: nil)
    }
    
    @IBAction func logoutButtonDidPressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: LOGGED_IN)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case ACCOUNTS_SECTION: return accountManager.accounts.count
        case LOGOUT_SECTION: return 1
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case ACCOUNTS_SECTION: return "Accounts"
        default: return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case ACCOUNTS_SECTION:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountTableCell
            cell.accountLabel.text = accountManager.accounts[indexPath.row]
            return cell
        case LOGOUT_SECTION:
            return tableView.dequeueReusableCell(withIdentifier: "LogoutCell", for: indexPath)
        default: return UITableViewCell()
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case ACCOUNTS_SECTION: return true
        default: return false
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let username = accountManager.accounts[indexPath.row]
            accountManager.removeAccount(username: username)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
