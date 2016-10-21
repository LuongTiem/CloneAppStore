//
//  CellDetailApp.swift
//  AppStore
//
//  Created by ReasonAmu on 10/21/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellDetailApp: UITableViewCell {
    
    @IBOutlet weak var nameTitle1: UILabel!
    
    @IBOutlet weak var subTitle1: UILabel!
    
    @IBOutlet weak var nameTitle2: UILabel!
    
    @IBOutlet weak var subTitle2: UILabel!
    
    @IBOutlet weak var nameTitle3: UILabel!
    
    @IBOutlet weak var subTitle3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTitle1.text = ""
        subTitle1.text = ""
        nameTitle2.text  = ""
        subTitle2.text = ""
        nameTitle3.text = ""
        subTitle3.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    var setupViews : DetailApp? {
        
        didSet{
            nameTitle1.text = "Description"
            subTitle1.text = setupViews?.description
            if let arrLanguages = setupViews?.languageCodesISO2A{
                var languages : String = ""
                for element in arrLanguages {
                    
                    languages  += "\(element),"
                }
                nameTitle2.text = "Languages:"
                subTitle2.text = languages
            }
            
            if let arrDevices = setupViews?.supportedDevices {
                var supportDevices : String = ""
                for element in arrDevices {
                    
                    supportDevices  += "\(element),"
                }
                nameTitle3.text = "Compatibility:"
                subTitle3.text = supportDevices
            }
            self.updateFocusIfNeeded()
        }
    }
    
    var setupReview : DetailApp?{
        
        didSet {
            nameTitle1.text = "ReleaseNotes"
            subTitle1.text = (setupReview?.releaseNotes)! + "\nUpdate: " + (setupReview?.currentVersionReleaseDate)!
            nameTitle2.text = "Support Minimum Os Version"
            subTitle2.text = setupReview?.minimumOsVersion
            nameTitle3.text = "Version"
            if let sizeApp = setupReview?.fileSizeBytes {
                let convertSize = Int(sizeApp)! / 1024
                 subTitle3.text = "Version: " + (setupReview?.version)! + "\nSize App: " + String(convertSize)
            }
           
            self.updateFocusIfNeeded()
        }
    }
    
    var setupRate : DetailApp?{
        
        didSet{
            nameTitle1.text = "Rate:"
            subTitle1.text = "Rate: " + (setupRate?.trackContentRating!)!
            
            if let rateCurrentVersion = setupRate?.userRatingCountForCurrentVersion {
                nameTitle2.text = "Current Version: "
                subTitle2.text = "\(rateCurrentVersion) Ratings"
            }
            if let rating = setupRate?.userRatingCount {
                nameTitle3.text = "All Versions:"
                subTitle3.text = "\(rating) Ratings"
            }
            self.updateFocusIfNeeded()
        }
    }
    
}
