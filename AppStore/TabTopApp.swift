//
//  TabTopApp.swift
//  AppStore
//
//  Created by ReasonAmu on 10/18/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher

class TabTopApp: BaseViewController {

    var listTopFreeApp = [Entry]()
    var listTopPaidApp = [Entry]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate  = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.clear
        tableview.register(UINib(nibName: "CellApp", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        //--

        
        DataManager.shareInstance.getTopFreeApp { (api) in
            self.listTopFreeApp = api.entry!
            self.navigationItem.title = api.title
            self.tableview.reloadData()
        }
        
        
        DataManager.shareInstance.getTopRaidApp { (api) in
            self.listTopPaidApp = api.entry!
            self.navigationItem.title = api.title
            self.tableview.reloadData()
        }
        
        
        let itemSegment = ["Top Free App", "Top Paid App"]
        initSegmentControl(listSegment: itemSegment)
        
    }
    
    
    
}


extension TabTopApp : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return listTopFreeApp.count
        }else if segmentedControl.selectedSegmentIndex == 1  {
            return listTopPaidApp.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    
            return 120
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            let stringURL = listTopFreeApp[indexPath.row].image
            let url = URL(string: stringURL!)!
            (cell as! CellApp).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
            (cell as! CellApp).App = listTopFreeApp[indexPath.row]
            
        }else if segmentedControl.selectedSegmentIndex == 1  {
            
            let stringURL = listTopPaidApp[indexPath.row].image
            let url = URL(string: stringURL!)!
            (cell as! CellApp).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
            (cell as! CellApp).App = listTopPaidApp[indexPath.row]
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      
     (cell as! CellApp).imageViews.kf.cancelDownloadTask()
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "detailview") as! DetailView
        
        if segmentedControl.selectedSegmentIndex == 0 {
            detailView.title = listTopFreeApp[indexPath.row].name
            detailView.data = listTopFreeApp[indexPath.row]
            navigationController?.pushViewController(detailView, animated: true)
        }else{
            detailView.title = listTopPaidApp[indexPath.row].name
            detailView.data = listTopPaidApp[indexPath.row]
            navigationController?.pushViewController(detailView, animated: true)
        }
        
    }
}

extension TabTopApp : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellApp
            cell.imageViews.kf.indicatorType = .activity
            return cell
        
        
    }
}
