//
//  TabTopMusic.swift
//  AppStore
//
//  Created by ReasonAmu on 10/18/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher



class TabTopMusic: BaseViewController {

    var listTopSong = [Entry]()
    var listTopAlbums = [Album]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource  = self
        
        tableview.register(UINib(nibName: "CellMusic", bundle: nil), forCellReuseIdentifier: "CellMusic")
        tableview.register(UINib(nibName: "CellAlbums", bundle: nil), forCellReuseIdentifier: "CellAlbums")
        
        DataManager.shareInstance.getTopSong { (api) in
            
            self.listTopSong = api.entry!
            self.navigationItem.title = api.title
            self.tableview.reloadData()
        }
        
        DataManager.shareInstance.getTopAlbumsNow { (api) in
            self.listTopAlbums = api.albums!
            self.navigationItem.title = api.title
            self.tableview.reloadData()
        }
        
        //-- SegmentedControl
        let listSgment = ["Top Song", "Top Albums"]
        initSegmentControl(listSegment: listSgment)
    }
    
    
    
    
}


extension TabTopMusic : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let stringURL = listTopSong[indexPath.row].image
            let url = URL(string: stringURL!)!
            (cell as! CellMusic).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
            (cell as! CellMusic).Music = listTopSong[indexPath.row]
        }else{
            
            let stringURL = listTopAlbums[indexPath.row].image
            let url = URL(string: stringURL!)!
            (cell as! CellAlbums).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
            (cell as! CellAlbums).Album = listTopAlbums[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (segmentedControl.selectedSegmentIndex == 1) {
            return 150
        }
        return 130
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return listTopSong.count
        }else{
            return listTopAlbums.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "detailview") as! DetailView
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            detailView.data = listTopSong[indexPath.row]
            detailView.title = listTopSong[indexPath.row].name
            navigationController?.pushViewController(detailView, animated: true)
        }else{
            detailView.data = listTopAlbums[indexPath.row]
            detailView.title = listTopAlbums[indexPath.row].name
            navigationController?.pushViewController(detailView, animated: true)
        }
        
    }
    
}


extension TabTopMusic : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellMusic", for: indexPath) as! CellMusic
            cell.imageViews.kf.indicatorType = .activity
            return cell
        }else{
            let cellAlbums = tableview.dequeueReusableCell(withIdentifier: "CellAlbums", for: indexPath) as! CellAlbums
            
            cellAlbums.imageViews.kf.indicatorType = .activity
            return cellAlbums
        }
        
    }
}
