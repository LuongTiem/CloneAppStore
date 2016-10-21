//
//  TabFeatured.swift
//  AppStore
//
//  Created by ReasonAmu on 10/18/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher
class TabFeatured: UIViewController {
    
    @IBOutlet weak var slideCollectionFeatured: UICollectionView!
    @IBOutlet weak var tableViews: UITableView!
    
    var listAPI = [CallAPI]()
    var listImageSlide: [String]?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.register(UINib(nibName: "CellTableViewFeatured", bundle: nil), forCellReuseIdentifier: "Cell")
        slideCollectionFeatured.register(UINib(nibName: "SlideCellFeatured", bundle: nil), forCellWithReuseIdentifier: "SlideCell")
        
        loadData()
        
        
        
        
    }
    
    
    
    func loadData(){
        
        DataManager.shareInstance.getTopFreeApp { (api) in
            self.listAPI.append(api)
            self.tableViews.reloadData()
        }
        
        
        DataManager.shareInstance.getTopRaidApp { (api) in
            self.listAPI.append(api)
            self.tableViews.reloadData()
        }
        
        DataManager.shareInstance.getTopAlbums { (api) in
            self.listAPI.append(api)
            self.tableViews.reloadData()
        }
        
        DataManager.shareInstance.getTopSong { (api) in
            self.listAPI.append(api)
            self.tableViews.reloadData()
        }
        
        
        DataManager.shareInstance.getTopMovies { (api) in
            self.listAPI.append(api)
            self.tableViews.reloadData()
            
        }
        
        DataManager.shareInstance.getTopEpisodes { (api) in
            self.listAPI.append(api)
            self.tableViews.reloadData()
    
        }
        
        DataManager.shareInstance.getDetailApp(stringID: "563718995") { (response) in
            self.listImageSlide = response.screenshotUrls
            self.slideCollectionFeatured.reloadData()
        }
       
        
    }
    
    
    
    
}



extension TabFeatured : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellTableViewFeatured
        cell.setUpTableCell = listAPI[indexPath.row]
        cell.selectionStyle = .none //-- bo hightlight khi chon cell
        cell.delegates = self
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listAPI.count
    }
}

extension TabFeatured: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 240
    }
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //  let allTabar = self.tabBarController?.viewControllers
     if indexPath.row == 0 {
     self.tabBarController?.selectedIndex = 1
     //            let tabTopFreeApp  = (allTabar?[1] as! UINavigationController).topViewController as! TabTopApp
     //                tabTopFreeApp.listTopApp = listTopFreeApp
     
     }else if (indexPath.row == 1) {
     self.tabBarController?.selectedIndex = 2
     }else if (indexPath.row == 2){
     self.tabBarController?.selectedIndex = 3
     }else{
     self.tabBarController?.selectedIndex = 0
     }
     }
     
     */
}


extension TabFeatured : PushDetailDelegate {
    
    func pushDetail(entry: Entry, title: String) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyboard.instantiateViewController(withIdentifier: "detailview") as! DetailView
        detailView.data = entry
        detailView.title = title
        navigationController?.pushViewController(detailView, animated: true)
    }
}


extension TabFeatured : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCell", for: indexPath) as! SlideCellFeatured
        cell.imageSlideCell.kf.indicatorType = .activity
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = listImageSlide?.count {
           
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let stringURL = listImageSlide?[indexPath.item]
        let url = URL(string: stringURL!)!
        (cell as! SlideCellFeatured).imageSlideCell.kf.setImage(with: url, options: [.transition(.flipFromLeft(0.75))])
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! SlideCellFeatured).imageSlideCell.kf.cancelDownloadTask()
    }
}

extension TabFeatured: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 100 , height: collectionView.frame.height)
    }
}



