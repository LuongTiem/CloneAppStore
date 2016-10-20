//
//  TopMovie.swift
//  AppStore
//
//  Created by ReasonAmu on 10/17/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation

class TopMovies : Entry {
    
//    var name: String?
//    var category : String?
//    var id :String?
//    var image : String?
//    
//    
//    init?(Entry : [String : AnyObject]) {
//        
//        guard let name = Entry["title"]?.value(forKey: "label") as? String else { return nil }
//        
//        guard let category = Entry["category"]?.value(forKeyPath: "attributes.label") as? String else { return nil }
//        
//        guard let id = Entry["id"]?.value(forKeyPath: "attributes.im:id") as? String else { return nil }
//        
//        guard let listImage = Entry["im:image"] as? [NSDictionary] else { return nil }
//        guard let image = listImage.last?.value(forKey: "label") as? String else { return nil }
//        
//        
//        
//        self.id = id
//        self.name = name
//        self.image = image
//        self.category = category
//        
//    }
    
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
