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
import AlamofireImage

class GalleryDownloadManager: NSObject {
    
    static let sharedInstance = GalleryDownloadManager()

    //MARK: RSS feed related.
    func getRSSFeed(urlString:String, completionHandler: @escaping ([GalleryImageModel]?) -> Void) {
        
        Alamofire.request(urlString).responseRSS() { response in
            if let rssFeedXML = response.result.value {
                let arrayOfGalleryItems = self.parseRSSFeedIntoItems(feed: rssFeedXML)
                completionHandler(arrayOfGalleryItems)
            } else {
                print("We failed with the following error: \(String(describing: response.error?.localizedDescription))")
                completionHandler(nil)
            }
        }
    }
    
    func parseRSSFeedIntoItems(feed:RSSFeed) -> [GalleryImageModel] {
        let feedItems = feed.items
        var arrayOfGalleryImageModels:[GalleryImageModel] = []
        
        for item in feedItems {
            //due to xml structure, this can contain multiple images, select first as we understand this is a feed from individuals and will only be one image per entry.
            let itemImageURL = item.imagesFromContent![0]
            let galleryItem = GalleryImageModel(with: itemImageURL, title: item.title!, date: item.pubDate!)
            arrayOfGalleryImageModels.append(galleryItem)
        }
        
        return arrayOfGalleryImageModels
    }
    
    //MARK: Utility Methods
    
    func getImage(from urlString:String, completionHandler: @escaping (UIImage?) -> Void){
        Alamofire.request(urlString).responseImage(completionHandler: { response in
            guard let image = response.result.value
                else {
                    print("We failed with the following error: \(String(describing: response.error?.localizedDescription))")
                    return
            }
            completionHandler(image)
        })
    }
    
}
