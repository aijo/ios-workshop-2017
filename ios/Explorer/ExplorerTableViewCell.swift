//
//  ExplorerTableViewCell.swift
//  ios
//
//  Created by JO10X on 10/13/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import UIKit

class ExplorerTableViewCell: UITableViewCell {
    
    // MARK: Object lifecycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView(){
        contentView.backgroundColor = UIColor.clear
        addSubview(itemsCollectionView)
        addSubview(sectionNameLabel)
        itemsCollectionView.addConstraint(NSLayoutConstraint(item: itemsCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (420/2)))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[sectionNameLabel]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["sectionNameLabel": sectionNameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[itemsCollectionView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["itemsCollectionView": itemsCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[sectionNameLabel(40)][itemsCollectionView]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["itemsCollectionView": itemsCollectionView, "sectionNameLabel": sectionNameLabel]))
        
        itemsCollectionView.register(ExplorerCollectionCell.self, forCellWithReuseIdentifier:"ExplorerCollectionCell")
    }
}

extension ExplorerTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        itemsCollectionView.delegate = dataSourceDelegate
        itemsCollectionView.dataSource = dataSourceDelegate
        itemsCollectionView.tag = row
        itemsCollectionView.setContentOffset(itemsCollectionView.contentOffset, animated:false)
        itemsCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { itemsCollectionView.contentOffset.x = newValue }
        get { return itemsCollectionView.contentOffset.x }
    }
}
