//
//  CellSlideApp.swift
//  AppStore
//
//  Created by ReasonAmu on 10/21/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher

class CellSlideApp: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var arrImage: [String]?
    var loadDetailApp : DetailApp? {
        didSet {
            
            collectionView.delegate  = self
            collectionView.dataSource = self
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            collectionView.register(UINib(nibName: "SlideCellFeatured", bundle: nil), forCellWithReuseIdentifier: "SlideCellFeatured")
            arrImage = loadDetailApp?.screenshotUrls
            collectionView.sizeToFit()
            collectionView.contentSize = CGSize(width: self.frame.width, height: 150)
           collectionView.reloadData()
        }
    }

   
    
    func setupCollectionView(){
        
        collectionView.delegate  = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        collectionView.register(UINib(nibName: "SlideCellFeatured", bundle: nil), forCellWithReuseIdentifier: "SlideCellFeatured")
    }
    
}




extension CellSlideApp : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCellFeatured", for: indexPath) as! SlideCellFeatured
        
            cell.imageSlideCell.kf.indicatorType = .activity
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = arrImage?.count {
            return count
        }
        return 0
    }
    
}



extension CellSlideApp : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let urlString = arrImage?[indexPath.item]
        let url = URL(string: urlString!)!
        (cell as! SlideCellFeatured).imageSlideCell.kf.setImage(with: url, options: [.transition(.fade(1))])
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! SlideCellFeatured).imageSlideCell.kf.cancelDownloadTask()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 , height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}
