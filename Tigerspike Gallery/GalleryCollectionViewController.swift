//
//  GalleryCollectionViewController.swift
//  Tigerspike Gallery
//
//  Created by Joshua Areogun on 05/11/2017.
//  Copyright © 2017 Joshua Areogun. All rights reserved.
//

import UIKit

class GalleryCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    fileprivate var galleryItems:[GalleryImageModel] = []
    var galleryDownloadManager:GalleryDownloadManager!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerReusableViews()
        setupCollectionView()
        fetchFeed(from: Configuration.DataSource.feedURL)
    }
    //MARK: Setup
    func registerReusableViews(){
        galleryCollectionView.register(UINib(nibName: Configuration.DataSource.collectionCellNibName, bundle: nil), forCellWithReuseIdentifier: Configuration.DataSource.collectionCellReuseIdentifier)
    }
    
    func setupCollectionView(){
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        let flowLayout = galleryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }
    
    //MARK: Image Service Interaction.
    func fetchFeed(from urlString:String){
        galleryDownloadManager.getRSSFeed(urlString: urlString, completionHandler: { response in
                self.galleryItems = response!
            DispatchQueue.main.async {
                self.galleryCollectionView.reloadData()
            }
        })
    }
    
    //MARK: Collection view datasource & delegate methods.
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Configuration.DataSource.numberOfItemsInSection
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: Configuration.DataSource.collectionCellReuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        cell.galleryDownloadDependency = galleryDownloadManager
        cell.prepareForData(with: galleryItems[indexPath.row])
        cell.contentView.alpha = 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8, animations: {
            cell.contentView.alpha = 1.0
        })
    }
}
