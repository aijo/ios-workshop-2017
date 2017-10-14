//
//  Item.swift
//  ios
//
//  Created by JO10X on 10/14/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import Foundation

struct Item: Codable {
    var location: String?
    var imageUrl: String?
    var username: String?
    var avatar: String?
    var likes: Int?
    var caption: String?
    var datetime: Date?
    var id: String?
    
    //*// Custom Mapping
    enum ItemKeys: String, CodingKey {
        case id = "id"
        case location = "location"
        case images = "images"
        case caption = "caption"
        case likes = "likes"
    } // */
    
    enum LocationKeys: String, CodingKey {
        case name
    }
    
    enum ImageKeys: String, CodingKey {
        case thumbnail
        case low_resolution
        case standard_resolution
    }
    
    enum CaptionKeys: String, CodingKey {
        case id
        case text
        case from
        case created_time
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ItemKeys.self)
        
        if let locationContainer = try? values.nestedContainer(keyedBy:     LocationKeys.self, forKey: .location) {
            location = try locationContainer.decode(String.self, forKey: .name)
        }
        
        if let imageContainer = try? values.nestedContainer(keyedBy: ImageKeys.self, forKey: .images) {
            let images = try imageContainer.decode([String: AnyJSONType].self, forKey: .standard_resolution)
            imageUrl = images["url"]?.jsonValue as? String
        }
        
        if let captionContainer = try? values.nestedContainer(keyedBy: CaptionKeys.self, forKey: .caption) {
            caption = try captionContainer.decode(String.self, forKey: .text)
            
            let createdTime = try captionContainer.decode(String.self, forKey: .created_time)
            if let dt = Double(createdTime) {
                datetime = Date(timeIntervalSince1970: dt)
            }
            
            let from = try captionContainer.decode([String: AnyJSONType].self, forKey: .from)
            username = from["username"]?.jsonValue as? String
            avatar = from["profile_picture"]?.jsonValue as? String
        }
        
        likes = try values.decode([String: AnyJSONType].self, forKey: .likes)["count"]?.jsonValue as? Int
        
        id = try values.decode(String.self, forKey: .id)
    }
    
}
