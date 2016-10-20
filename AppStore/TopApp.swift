//
//  TopApp.swift
//  AppStore
//
//  Created by ReasonAmu on 10/17/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation


class Entry {
    
    var name : String?
    var image : String?
    var price : String?
    var id  :String?
    var category : String?
    var title : String?
    var artists : String?
    
    init?(Entry : [String: AnyObject]) {
        
        guard let name = Entry["im:name"]?.value(forKey: "label") as? String else {
            return nil
        }
        
        guard let listImage = Entry["im:image"] as? [NSDictionary] else {
            return nil
        }
        guard let image = listImage.last?.value(forKey: "label") as? String else {  return nil }
        
        guard let price = Entry["im:price"]?.value(forKey: "label") as? String else { return nil }
        
        guard let id = Entry["id"]?.value(forKeyPath: "attributes.im:id") as? String else { return nil }
        
        guard let category = Entry["category"]?.value(forKeyPath: "attributes.label") as? String else { return nil }
        
        guard let artist = (Entry["im:artist"] as? NSDictionary)?.value(forKey: "label") as? String else {
            return nil
        }
        
        self.price = price
        self.name = name
        self.image = image
        self.id = id
        self.category = category
        self.artists = artist
       
        
    }
    
}

class CallAPI {
    
    var entry: [Entry]?
    var title: String?
    
    init?(feed : [String : AnyObject] ) {
        
        guard let entryArr = feed["entry"] as? [AnyObject] else {
            return nil
        }
        
        var listEntry = [Entry]()
        for entry in entryArr {
            let catEntry = entry as? [String : AnyObject]
            let entryElement = Entry.init(Entry: catEntry!)!
            listEntry.append(entryElement)
        }
        
        guard let title = feed["title"]?.value(forKey: "label") as? String else {
            return nil
        }
        
        
        self.title = title
        self.entry = listEntry
    }
}








