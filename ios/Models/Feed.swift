//
//  Feed.swift
//  ios
//
//  Created by JO10X on 10/14/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import Foundation

struct Feed: Codable {
    var status: String?
    var username: String?
    var items: [Item]?
}
