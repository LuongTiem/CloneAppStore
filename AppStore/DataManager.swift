//
//  DataManager.swift
//  AppStore
//
//  Created by ReasonAmu on 10/17/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation
import Alamofire


class DataManager {
    
    
    static let linkTopSong = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=10/json"
    
    static let linkTopAlbums = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topalbums/limit=10/json"
    
    static let linkTopRaidApp = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit="
    
    static let linkTopFreeApp = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit="
    
    static let linkTopMovies = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/json"
    static let linkTopTvSeasons = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topTvSeasons/json"
    static let linkTopTvEpisodes  = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topTvEpisodes/json"
    
    static let linkGetFull  = "http://itunes.apple.com/lookup?id="
    
    
    static let TOPFREE = "TOPFREE"
    static let TOPRAID = "TOPRAID"
    
    
    private init(){
        
    }
    
    static let shareInstance = DataManager()
    
    
    
    
    
    
    //--
    func getTopFreeApp(element : Int , completion : @escaping (CallAPI) -> ()){
        
        let stringURL =  DataManager.linkTopFreeApp  +  "\(element)/json"
        let url = URL(string: stringURL)!
        
        Alamofire.request(url).responseJSON { (response) in
            
            
            if let json = response.result.value as? [String: AnyObject]{
                
                let feed = json["feed"] as? [String : AnyObject]
                let api = CallAPI.init(feed: feed!)
                completion(api!)
                
                
            }
        }
    }
    
    
    
    //-- get Top Raid App
    
    func getTopRaidApp(element : Int , completion : @escaping (CallAPI) -> ()){
        
        let stringURL =  DataManager.linkTopRaidApp  +  "\(element)/json"
        let url = URL(string: stringURL)!
        
        Alamofire.request(url).responseJSON { (response) in
            
            
            if let json = response.result.value as? [String: AnyObject]{
                
                let feed = json["feed"] as? [String : AnyObject]
                let api = CallAPI.init(feed: feed!)
                completion(api!)
                
                
            }
        }        }
    
    
    //-- get Top Song
    
    func getTopSong(completion : @escaping (CallAPI)->()){
        let url = URL(string: DataManager.linkTopSong)!
        Alamofire.request(url).responseJSON { (response) in
            if let json = response.result.value as? [String: AnyObject]{
                let feed = json["feed"] as? [String : AnyObject]
                let api = CallAPI.init(feed: feed!)
                completion(api!)
                
            }
        }
        
    }
    
    
    //-- get Top Albums
    
    func getTopAlbums(completion : @escaping (CallAPI)-> ()){
        let url = URL(string: DataManager.linkTopAlbums)!
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value as? [String: AnyObject]{
                let feed = json["feed"] as? [String : AnyObject]
                let api = CallAPI.init(feed: feed!)
                completion(api!)
                
            }
            
        }
    }
    
    
    //-- get Top Movies
    
    func getTopMovies (completion : @escaping (CallAPI)->()){
        
        let url = URL(string: DataManager.linkTopMovies)!
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value as? [String: AnyObject]{
                let feed = json["feed"] as? [String : AnyObject]
                let api = CallAPI.init(feed: feed!)
                completion(api!)
                
            }
            
        }
        
    }
    
    
    //-- get Top TV Episodes
    
    func getTopEpisodes(completion : @escaping (CallAPI)->()){
        
        let url = URL(string: DataManager.linkTopTvEpisodes)!
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value as? [String: AnyObject]{
                let feed = json["feed"] as? [String : AnyObject]
                let api = CallAPI.init(feed: feed!)
                completion(api!)
                
            }
            
        }
        
    }
    
    
    //-- get Top Seasons
    
    func getTopSeasons(completion : @escaping (CallAPI)->()){
        
        let url = URL(string: DataManager.linkTopTvSeasons)!
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value as? [String: AnyObject]{
                let feed = json["feed"] as? [String : AnyObject]
                let api = CallAPI.init(feed: feed!)
                completion(api!)
                
            }
        }
        
    }
    
    
    func getTopAlbumsNow(completion : @escaping (API_Albums)->()){
        
        
        let url = URL(string: DataManager.linkTopAlbums)!
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value as? [String: AnyObject]{
                let feed = json["feed"] as? [String : AnyObject]
                let api = API_Albums.init(feed: feed!)
                completion(api!)
                
            }
        }
    }
    
    
    //-- get DetailApp
    
    
    func getDetailApp (stringID : String , completion : @escaping (DetailApp) -> ()) {
        
        let url = URL(string: DataManager.linkGetFull + stringID)!
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value as? [String: AnyObject]{
                
                let api = DetailApp.init(json: json)
                if api != nil {
                    completion(api!)
                }else{
                    return
                }
                
                
            }
            
        }
        
    }
    
    
    //-- get Deatail Song
    
    func getDetailSong(stringID : String , completion : @escaping (DetailSong) -> ()){
        
        let url = URL(string: DataManager.linkGetFull + stringID)!
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value as? [String: AnyObject]{
                
                let api = DetailSong.init(json: json)
                if api != nil {
                    completion(api!)
                }else{
                    
                    return
                }
                
            }
            
        }
        
    }
    
    //-- getDeail Albums
    
    func getDetailAlbums(stringID : String , completion : @escaping (DetailAlbum) -> ()){
        
        let url = URL(string: DataManager.linkGetFull + stringID)!
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value as? [String: AnyObject]{
                
                let api = DetailAlbum.init(json: json)
                
                if api != nil {
                    completion(api!)
                }else{
                    
                    return
                }
                
                
            }
            
        }
        
    }
    
    
}
