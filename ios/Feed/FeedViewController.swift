//
//  FeedViewController.swift
//  ios
//
//  Created by JO10X on 10/14/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {
    
    var feed: Feed?
    private var lastMaxId: String?
    private let service = Services.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = feed?.username
        lastMaxId = feed?.items?.last?.id
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func loadFeedData() {
        if let username = feed?.username {
            service.getInstagramFeed(user: username, maxId: lastMaxId) { [unowned self] (feed, error) in
                if let items = feed?.items {
                    self.lastMaxId = items.last?.id
                    self.feed?.items?.append(contentsOf: items)
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = feed?.items {
            return items.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell {
            if let item = feed?.items?[indexPath.row] {
                cell.setupCell(item: item)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let items = feed?.items {
            let lastElement = items.count - 1
            if indexPath.row == lastElement {
                loadFeedData()
            }
        }
    }

}
