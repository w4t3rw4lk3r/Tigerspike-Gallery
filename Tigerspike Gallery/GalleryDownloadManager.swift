//
//  GalleryDownloadManager.swift
//  Tigerspike Gallery
//
//  Created by Joshua Areogun on 05/11/2017.
//  Copyright © 2017 Joshua Areogun. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireRSSParser

public enum NetworkResponseStatus {
    case success
    case error(string: String?)
}


class GalleryDownloadManager: NSObject {
    
    static let sharedInstance = GalleryDownloadManager()

    
    func getRSSFeed(urlString:String, completionHandler: @escaping (_ response: RSSFeed?,_ status: NetworkResponseStatus) -> Void) {
        
        Alamofire.request(urlString).responseRSS() { response in
            if let rssFeedXML = response.result.value {
                completionHandler(rssFeedXML, .success)
            } else {
                completionHandler(nil, .error(string:response.result.error?.localizedDescription))
            }
        }
        
    }
    
}
