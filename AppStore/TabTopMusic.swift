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
        let stringURL = listTopAlbums[indexPath.row].image
        let url = URL(string: stringURL!)!
        (cell as! CellMusic).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
        (cell as! CellMusic).Music = listTopAlbums[indexPath.row]
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! CellMusic).imageViews.kf.cancelDownloadTask()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTopAlbums.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "detailview") as! DetailView
        detailView.data = listTopAlbums[indexPath.row]
        detailView.title = listTopAlbums[indexPath.row].name
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}


extension TabTopMusic : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMusic", for: indexPath) as! CellMusic
        cell.imageViews.kf.indicatorType = .activity
        return cell
    }
}
