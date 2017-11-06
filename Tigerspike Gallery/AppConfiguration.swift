//
//  AppConfiguration.swift
//  Tigerspike Gallery
//
//  Created by Joshua Areogun on 05/11/2017.
//  Copyright © 2017 Joshua Areogun. All rights reserved.
//

import UIKit

struct Configuration {
    
    struct DataSource {
        static let feedURL:String = "https://api.flickr.com/services/feeds/photos_public.gne"
        //Collection view
        static let numberOfItemsInSection:Int = 1
        static let collectionCellReuseIdentifier:String = "galleryCollectionCell"
        static let collectionCellNibName:String = "GalleryCollectionViewCell"
    }
}
