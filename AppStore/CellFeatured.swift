//
//  CellFeatured.swift
//  AppStore
//
//  Created by ReasonAmu on 10/18/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellFeatured: UICollectionViewCell {

    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var category: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    var setUpCell : Entry?{
        
        didSet{
            if let price = setUpCell?.price {
                self.price.text = price
            }
            if let name = setUpCell?.name {
                self.name.text = name
            }
            if let category = setUpCell?.category {
                self.category.text = category
            }
        }
    }

}
