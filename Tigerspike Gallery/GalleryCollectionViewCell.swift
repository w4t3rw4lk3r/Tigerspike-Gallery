//
//  GalleryCollectionViewCell.swift
//  Tigerspike Gallery
//
//  Created by Joshua Areogun on 05/11/2017.
//  Copyright © 2017 Joshua Areogun. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDateLabel: UILabel!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var whiteCard: UIView!
    
    var galleryDownloadDependency:GalleryDownloadManager!
    
    //MARK: Lifecycle.
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    //MARK: Cell setup
    func setupView(){
        whiteCard.layer.cornerRadius = 5.0
        imageView.layer.cornerRadius = 5.0
        imageView.contentMode = .scaleAspectFit
    }
    
    func prepareForData(with itemModel:GalleryImageModel) {
        let dateString = getdateString(from: itemModel.imageDate)
        self.imageDateLabel.text = dateString
        self.imageTitleLabel.text = itemModel.imageTitle
        getImage(with: itemModel.imageURLString)
    }
    
    //MARK: Utility Methods
    func getdateString(from date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from:date)
        return dateString
    }
    
    func getImage(with urlString:String) {
        galleryDownloadDependency.getImage(from: urlString, completionHandler: { response in
            self.setCellImage(with: response!)
        })
    }
    
    func setCellImage(with image:UIImage) {
        self.imageView.image = image
    }
}
