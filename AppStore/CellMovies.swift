//
//  CellMovies.swift
//  AppStore
//
//  Created by ReasonAmu on 10/19/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellMovies: UICollectionViewCell {


    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageViews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        imageViews.layer.cornerRadius = 5
        imageViews.layer.masksToBounds = true
        
    }
    
    


}
