//
//  CellMusic.swift
//  AppStore
//
//  Created by ReasonAmu on 10/20/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellMusic: UITableViewCell {
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var nameSong: UILabel!

    @IBOutlet weak var imageViews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var Music : Entry? {
        
        didSet{
          
            author.text = Music?.artists
            nameSong.text = Music?.name
            category.text = Music?.category
            price.text = Music?.price
            
            
            //self.contentView.round(corners: [.topRight, .bottomRight], radius: 10, borderColor: UIColor.lightGray, borderWidth: 1)
            
            
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
