//
//  Services.swift
//  ios
//
//  Created by JO10X on 10/14/17.
//  Copyright © 2017 aijo. All rights reserved.
//

import Foundation
import Alamofire

class Services {
    
    let jsonDecoder = JSONDecoder()
    typealias mediaCompletion = (_ feed: Feed?, _ error: Error?) -> Void
    
    func getInstagramFeed(user: String, completion: @escaping mediaCompletion) {
        let mediaEndpoint = "https://www.instagram.com/\(user)/media/"
        
        Alamofire.request(mediaEndpoint, method: .get, parameters: nil).responseData { (response) in
            switch response.result {
            case .success(let data):
                let feed = try! self.jsonDecoder.decode(Feed.self, from: data)
                completion(feed, nil)
            case .failure(let error):
                print("Request failed with error: \(error)")
                completion(nil, error)
            }
        }
    }
    
    typealias downloadProgress = (_ progress: Double) -> Void
    typealias uiImageCompletion = (_ image: UIImage?, _ error: Error?) -> Void
    
    func getImage(imageUrl: String, downloadProgress: @escaping downloadProgress, completion: @escaping uiImageCompletion) {
        Alamofire.request(imageUrl)
            .downloadProgress { progress in
                downloadProgress(progress.fractionCompleted)
            }
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(UIImage(data: data), nil)
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil, error)
                }
        }
    }
    
}
