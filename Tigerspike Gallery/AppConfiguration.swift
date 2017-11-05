//
//  AppConfiguration.swift
//  Tigerspike Gallery
//
//  Created by Joshua Areogun on 05/11/2017.
//  Copyright © 2017 Joshua Areogun. All rights reserved.
//

import UIKit

struct Configuration {
    struct Errors {
        static let kDownloadFailedImage:String = "imageNotFound.png"
        static let kUnavailableImage:String = "unavailableImage.jpg"
        static let kUnavailableImageMessage:String = "No Images"
    }
    
    struct DataSource {
        //Collection view columns.
        static let kNumberOfItemsInSection:Int = 1
    }
}
