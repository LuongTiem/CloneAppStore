//
//  SlideCellFeatured.swift
//  AppStore
//
//  Created by ReasonAmu on 10/19/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher

class SlideCellFeatured: UICollectionViewCell {
    
    @IBOutlet weak var imageSlideCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSlideCell.isUserInteractionEnabled = true
        setupGestureImage()
    }
    
    
    
    
    func setupGestureImage() {
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(touchImage))
        self.addGestureRecognizer(tapImage)
        
    }
    
    var detailController : DetailView?
    
    func touchImage(){
        
                
    }
    
    
    
    
}
