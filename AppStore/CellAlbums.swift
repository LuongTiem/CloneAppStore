//
//  CellAlbums.swift
//  AppStore
//
//  Created by ReasonAmu on 10/20/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellAlbums: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var nameAlbums: UILabel!
    
    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var numberSong : UILabel!
    
    
    
    
    var Album : Album? {
        
        didSet{
            
            author.text = Album?.artists
            nameAlbums.text = Album?.name
            category.text = Album?.category
            price.text = Album?.price
            if let number  = Album?.numberSong {
                numberSong.text = number
            }
            
        
            
            
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
