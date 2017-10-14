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
    var items = [Item]()
    var cacheHeight = [Int:CGFloat]()
    
    private let service = Services.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = feed?.username
        
        if let items = feed?.items {
            self.items.append(contentsOf: items)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func loadFeedData() {
        if let username = feed?.username {
            let lastMaxId = items.last?.id
            service.getInstagramFeed(user: username, maxId: lastMaxId) { [unowned self] (feed, error) in
                if let newItems = feed?.items {
                    let currentSize = self.items.count
                    self.items.append(contentsOf: newItems)
                    
                    var indexPaths = [IndexPath]()
                    for i in currentSize...self.items.count-1 {
                        indexPaths.append(IndexPath.init(row: i, section: 0))
                    }
                    self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.none)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell {
            cell.setupCell(item: items[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cacheHeight[indexPath.row] {
            return height
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cacheHeight[indexPath.row] = cell.frame.size.height
        
        let lastElement = items.count - 1
        if indexPath.row == lastElement {
            loadFeedData()
        }
    }

}
