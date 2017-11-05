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
    var galleryViewModel:GalleryViewModel!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func registerReusableViews(){
        
    }
    
    func setupCollectionView(){
        galleryViewModel = GalleryViewModel()
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        let flowLayout = galleryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }
    
    //MARK: Collection view datasource & delegate methods.
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Configuration.DataSource.kNumberOfItemsInSection
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //should be the datasource array count.
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}
