//
//  ExplorerViewController.swift
//  ios
//
//  Created by JO10X on 10/13/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import UIKit

class ExplorerViewController: UITableViewController {
    
    private var explorerList: [ExplorerSection]?
    private var storedOffsets = [Int: CGFloat]()
    private let service = Services()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Explorer"
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.tableView.register(ExplorerTableViewCell.self, forCellReuseIdentifier: "ExplorerCell")
        prepareData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func prepareData() {
        explorerList = [ExplorerSection]()
        loadFeedData(username: "apple")
        loadFeedData(username: "aijojoe")
    }
    
    fileprivate func loadFeedData(username: String) {
        service.getInstagramFeed(user: username) { [unowned self] (feed, error) in
            let explorerItems = feed?.items?.map({ (item) -> ExplorerItem in
                ExplorerItem(title: item.caption, imageURL: item.imageUrl)
            })
            
            self.explorerList?.append(ExplorerSection(sectionTitle: "Highlight of \(username)", explorerItems: explorerItems))
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let size = explorerList?.count {
            return size
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ExplorerCell", for: indexPath) as? ExplorerTableViewCell {
            let item = explorerList![indexPath.row]
            cell.sectionNameLabel.text = item.sectionTitle
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ExplorerTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = explorerList?[indexPath.row] {
            self.performSegue(withIdentifier: "gotoFeed", sender: item)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoFeed" {
            if let feedViewController = segue.destination as? FeedViewController {
                if let explorer = sender as? ExplorerSection {
                    feedViewController.explorer = explorer
                }
            }
        }
    }

}

extension ExplorerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collections view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let index = collectionView.tag
        if let explorerItems = self.explorerList?[index].explorerItems {
            return explorerItems.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = collectionView.tag
        if let explorerItem = self.explorerList?[index].explorerItems?[indexPath.row] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExplorerCollectionCell", for: indexPath) as! ExplorerCollectionCell
            cell.titleLabel.text = explorerItem.title
            if let image = explorerItem.imageURL {
                service.getImage(imageUrl: image, downloadProgress: { (progress) in
                    //print(progress)
                }) { (image, error) in
                    cell.imageView.image = image
                }
            }

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = collectionView.frame.height - 10
        return CGSize(width: 324/2, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tableCell = collectionView.superview as? UITableViewCell {
            if let idx = tableView.indexPath(for: tableCell) {
                tableView(tableView, didSelectRowAt: idx)
            }
        }
    }

}

