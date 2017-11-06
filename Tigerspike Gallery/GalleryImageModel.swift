//
//  GalleryImageModel.swift
//  Tigerspike Gallery
//
//  Created by Joshua Areogun on 05/11/2017.
//  Copyright © 2017 Joshua Areogun. All rights reserved.
//

import UIKit

class GalleryImageModel: NSObject {
    
    var imageURLString:String!
    var imageTitle:String!
    var imageDate:Date!
    
    init(with urlString:String, title:String, date:Date){
        self.imageURLString = urlString
        self.imageTitle = title
        self.imageDate = date
    }
}
