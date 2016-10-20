//
//  TopMusic.swift
//  AppStore
//
//  Created by ReasonAmu on 10/17/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation


class API_Albums : CallAPI {
    
    var albums : [Album]?
    
    override init?(feed: [String : AnyObject]) {
        super.init(feed: feed)
        
        guard let entryArr = feed["entry"] as? [AnyObject] else {
            return nil
        }
        
        var listAlbums = [Album]()
        for entry in entryArr {
            let catEntry = entry as? [String : AnyObject]
            let entryElement = Album.init(Entry: catEntry!)!
            listAlbums.append(entryElement)
        }
        
        guard let title = feed["title"]?.value(forKey: "label") as? String else {
            return nil
        }
        
        
        self.title = title
        self.albums = listAlbums
        
    }
    
}




class Album : Entry {
    
    var numberSong : String?
    
    override init?(Entry: [String : AnyObject]) {
        super.init(Entry: Entry)
        guard let numberSong = Entry["im:itemCount"]?.value(forKey: "label")  as? String else {
            return nil
        }
        self.numberSong = numberSong
    }
    
    
    
    
}
