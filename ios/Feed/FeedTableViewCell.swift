//
//  FeedTableViewCell.swift
//  ios
//
//  Created by JO10X on 10/14/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    private let USER_IMAGE_SIZE:CGFloat = 35
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImageView.backgroundColor = UIColor.init(rgba: "#EEEEEE")
        photoImageView.backgroundColor = UIColor.init(rgba: "#EEEEEE")
        userImageView.layer.cornerRadius = USER_IMAGE_SIZE/2
        userImageView.layer.masksToBounds = true
    }
    
    func setupCell(item: Item) {
        userLabel.text = item.username ?? ""
        locationLabel.text = item.location ?? ""
        contentLabel.text = item.caption ?? ""
        likeLabel.text = "♥ \(item.likes ?? 0)"
    }

}
