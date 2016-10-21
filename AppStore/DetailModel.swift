//
//  TopMovie.swift
//  AppStore
//
//  Created by ReasonAmu on 10/17/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation

class DetailApp {
    
    
    //-- detail
    var screenshotUrls : [String]?
    var supportedDevices : [String]?
    var languageCodesISO2A : [String]?
    var description : String?
    
    
    
    var minimumOsVersion: String?
    var version :String?
    var releaseNotes : String?
    var currentVersionReleaseDate : String?
    var fileSizeBytes : String?
    
    
    //-- rate
    var userRatingCountForCurrentVersion : Int?
    var userRatingCount: Int?
    var trackContentRating : String?
    
    
    
    
    
    init?(json : [String : AnyObject]) {
        
        guard let result = json["results"] as? [AnyObject]else {
            return nil
        }
        
        let catJson = result[0] as? [String : AnyObject]
        
        //--
        guard let screenshotUrls = catJson?["screenshotUrls"] as? [String] else {
            return nil
        }
        
        guard let supportedDevices = catJson?["supportedDevices"] as? [String] else {
            return nil
        }
        
        guard let languageCodesISO2A = catJson?["languageCodesISO2A"] as? [String] else {
            return nil
        }
        
        guard let fileSizeBytes = catJson?["fileSizeBytes"] as? String else {
            return nil
        }
        
        
        
        
        guard let trackContentRating = catJson?["trackContentRating"] as?  String else {
            return nil
        }
        
        guard let currentVersionReleaseDate = catJson?["currentVersionReleaseDate"] as?  String else {
            return nil
        }
        
        guard let version = catJson?["version"] as?  String else {
            return nil
        }
        
        guard let description = catJson?["description"] as?  String else {
            return nil
        }
        
        guard let releaseNotes = catJson?["releaseNotes"] as?  String else {
            return nil
        }
        
        
        guard let minimumOsVersion = catJson?["minimumOsVersion"] as?  String else {
            return nil
        }
        
        
        
        
        guard let userRatingCountForCurrentVersion = catJson?["userRatingCountForCurrentVersion"] as?  Int else {
            return nil
        }
        guard let userRatingCount = catJson?["userRatingCount"] as?  Int else {
            return nil
        }
        
        
        self.screenshotUrls = screenshotUrls
        self.supportedDevices = supportedDevices
        self.languageCodesISO2A = languageCodesISO2A
        self.fileSizeBytes = fileSizeBytes
        self.userRatingCountForCurrentVersion = userRatingCountForCurrentVersion
        self.releaseNotes = releaseNotes
        self.currentVersionReleaseDate = currentVersionReleaseDate
        self.trackContentRating = trackContentRating
        self.version = version
        self.description = description
        self.userRatingCount = userRatingCount
        self.minimumOsVersion = minimumOsVersion
        
        
        
        
        
    }
    
}






class DetailSong {
    
    var previewUrl: String?
    var releaseDate : String?
    
    init?(json: [String : AnyObject]) {
        
        
        guard let result = json["results"] as? [AnyObject]else {
            return nil
        }
        let catJson = result[0] as? [String : AnyObject]
        
        guard let releaseDate = catJson?["releaseDate"] as? String else {
            return nil
        }
        
        guard let previewUrl = catJson?["previewUrl"] as? String else {
            return nil
        }
        self.previewUrl = previewUrl
        self.releaseDate = releaseDate
    }
    
}

class DetailAlbum {
    var releaseDate : String?
    
    init?(json : [String : AnyObject]) {
        
        guard let result = json["results"] as? [AnyObject]else {
            return nil
        }
        let catJson = result[0] as? [String : AnyObject]
        
        guard let releaseDate = catJson?["releaseDate"] as? String else {
            return nil
        }
        
        self.releaseDate = releaseDate
    }
}



class Movies {
    
    var kind:String? //-- the loai
    var artistName : String?   //-- ten tac gia
    var collectionName: String? //-- ten bo su tap
    var artworkUrl100 : String? //-- link anh
    var trackHdPrice : String? //-- gia
    var trackCount : String? //-- so luot theo doi
    var primaryGenreName : String? //-- the loai
    
    var trackName:String? //-- ten
    var previewUrl: String? //-- link Video -- co trong movie , reason
    
    
    var longDescription : String? //-- tom tat
    
    
    
    var collectionPrice : String? //-- gia2
    
    init?(results : [String : AnyObject]) {
        
        guard let artistName = results["artistName"] as? String else {
            print("k cast dc ")
            return nil }
        // guard let collectionName = results["collectionName"]  as? String else { return nil }
        guard let artworkUrl100 = results["artworkUrl100"] as? String else { return nil }
        // guard let trackHdPrice = results["trackHdPrice"] as? String else { return nil }
        //  guard let trackCount = results["trackCount"] as? String else { return nil }
        guard let primaryGenreName = results["primaryGenreName"] as? String else { return nil }
        //        guard let trackName = results["trackName"] as? String else { return nil }
        //        guard let longDescription = results["longDescription"] as? String else { return nil }
        //        guard let collectionPrice = results["collectionPrice"] as? String else { return nil }
        //        guard let kind = results["kind"] as? String else { return nil }
        //        guard let previewUrl = results["previewUrl"] as? String else { return nil }
        
        //        self.kind = kind
        self.artistName = artistName
        //  self.collectionName = collectionName
        self.artworkUrl100 = artworkUrl100
        // self.trackHdPrice = trackHdPrice
        //  self.trackCount = trackCount
        self.primaryGenreName = primaryGenreName
        //        self.trackName = trackName
        //        self.previewUrl = previewUrl
        //        self.longDescription = longDescription
        //        self.collectionPrice = collectionPrice
    }
    
    
    
}
