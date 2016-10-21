//
//  BaseDetailView.swift
//  AppStore
//
//  Created by ReasonAmu on 10/21/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher

class BaseDetailView: BaseViewController {

  
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameApp: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var btnPrice: UIButton!

    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
  
    
    func setupHeaderTitleView (data : Entry ,radius : CGFloat){
        let cornerRadius = RoundCornerImageProcessor(cornerRadius: radius)
        let url = URL(string: (data.image)!)!
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2)), .processor(cornerRadius)])
        
        nameApp.text = data.name
        category.text = data.category
        
        btnPrice.setTitle(data.price, for: UIControlState.normal)
        btnPrice.layer.cornerRadius = 5
        btnPrice.layer.borderWidth = 1
        btnPrice.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        btnPrice.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        
    }
 
 
}
