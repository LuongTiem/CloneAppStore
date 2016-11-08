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
    
    var loadElementFree : Int = 20
    var loadElementRaid : Int = 20
    
    //-- loading
    let refeshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableview.delegate  = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.clear
        tableview.register(UINib(nibName: "CellApp", bundle: nil), forCellReuseIdentifier: "Cell")
        tableview.addSubview(refeshControl)
        setupFooterView(showFooter: false)
        
      
        //-- init segment
        let itemSegment = ["Top Free App", "Top Paid App"]
        initSegmentControl(listSegment: itemSegment)
        
        
        //-- init data
        loadData(element: nil, loadType: DataManager.TOPFREE)
        loadData(element: nil, loadType: DataManager.TOPRAID)
        
        
    }
    
    
    
    //MARK: UIVIEW FOOTER
    var indicatorLoading : UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.color = UIColor.red
        loading.hidesWhenStopped = true
        return loading
    }()
    
    var  viewFooter : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    
    //-- setup FooterView
    
    func setupFooterView (showFooter : Bool){
        
        if showFooter == true {
            viewFooter.frame = CGRect(x: 0, y: 0, width: tableview.frame.width, height: 30)
            self.viewFooter.addSubview(indicatorLoading)
            indicatorLoading.centerXAnchor.constraint(equalTo: viewFooter.centerXAnchor).isActive = true
            indicatorLoading.centerYAnchor.constraint(equalTo: viewFooter.centerYAnchor).isActive = true
            indicatorLoading.widthAnchor.constraint(equalToConstant: 30).isActive = true
            indicatorLoading.heightAnchor.constraint(equalToConstant: 30).isActive = true
            indicatorLoading.startAnimating()
            viewFooter.updateFocusIfNeeded()
            self.tableview.tableFooterView = viewFooter
            self.tableview.setNeedsFocusUpdate()
        }else{
            self.indicatorLoading.stopAnimating()
            self.tableview.tableFooterView = nil
        }
        
        
    }
    
    
    //MARK: - LOAD DATA
    func loadData(element : Int?, loadType : String){
        
        loadType == DataManager.TOPFREE ? loadDataTopFree(element: element) : loadDataTopRaid(element: element)
        self.setupFooterView(showFooter: false)
    }
    
    //-- load data free
    func loadDataTopFree(element : Int?){
        
        if  element == nil {
            DataManager.shareInstance.getTopFreeApp(element: 10) { (api) in
                self.listTopFreeApp = api.entry!
                self.navigationItem.title = api.title
                self.tableview.reloadData()
            }
            return
        }
        DataManager.shareInstance.getTopFreeApp(element: element!) { (api) in
            var appendAPI = [Entry]()
            for (index,element1) in  (api.entry!).enumerated() {
                if index < self.loadElementFree - 10 {
                    //  print(index)
                    //  resultAPI.remove(at: index)
                }else{
                   appendAPI.append(element1)
                }
                
            }
            self.listTopFreeApp.append(contentsOf: appendAPI)
            self.tableview.reloadData()
            self.loadElementFree += 10
            
        }
        
    }
    //-- load data raid
    func loadDataTopRaid(element : Int?){
        
        if  element == nil {
            DataManager.shareInstance.getTopRaidApp(element: 10) { (api) in
                self.listTopPaidApp = api.entry!
                self.navigationItem.title = api.title
                self.tableview.reloadData()
            }
            return
        }
        
        DataManager.shareInstance.getTopRaidApp(element: element!) { (api) in
            var appendAPI = [Entry]()
            for (index,element1) in  (api.entry!).enumerated() {
                if index < self.loadElementRaid - 10 {
                  
                }else{
                   appendAPI.append(element1)
                   
                }
                
            }
            self.listTopPaidApp.append(contentsOf: appendAPI)
            self.tableview.reloadData()
            self.loadElementRaid += 10
            
        }
        
    }
    
    
}


extension TabTopApp : UITableViewDelegate {
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if refeshControl.isRefreshing {
            
            if segmentedControl.selectedSegmentIndex  == 0 {
                loadData(element: loadElementFree, loadType: DataManager.TOPFREE)
            }else{
                loadData(element: loadElementRaid, loadType: DataManager.TOPRAID)
            }
            refeshControl.endRefreshing()
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            
            
            if segmentedControl.selectedSegmentIndex  == 0 {
                loadData(element: loadElementFree, loadType: DataManager.TOPFREE)
            }else if segmentedControl.selectedSegmentIndex  == 1 {
                loadData(element: loadElementRaid, loadType: DataManager.TOPRAID)
            }
            self.setupFooterView(showFooter: true)
            
        }
        
    }
    
    
    
    
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
