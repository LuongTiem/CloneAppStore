//
//  DetailView.swift
//  AppStore
//
//  Created by ReasonAmu on 10/19/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher


class DetailView: BaseDetailView {
    var data: Entry?
    var dataDetail : DetailApp?
    var dataSong: DetailSong?
    var resultSegment: Int = 0
    var KEY : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showList))
        
        tableview.delegate = self
        tableview.dataSource = self
        self.tableview.rowHeight = UITableViewAutomaticDimension
        setupHeaderTitleView(data : data! ,radius: 16)
        
        
        tableview.register(UINib(nibName: "CellSlideApp", bundle: nil), forCellReuseIdentifier: "CellSlideApp")
        tableview.register(UINib(nibName: "CellDetailApp", bundle: nil), forCellReuseIdentifier: "CellDetailApp")
        tableview.register(UINib(nibName: "CellDetailSong", bundle: nil), forCellReuseIdentifier: "CellDetailSong")
        
        
        let listSegment = ["Detail", "Review", "Rate"]
        initSegmentControl(listSegment: listSegment)
        
        loadData()
        
        
        
        
    }
    
    
    
    func loadData(){
        DataManager.shareInstance.getDetailApp(stringID: (data?.id)!) { (result) in
            
            self.dataDetail = result
            self.KEY = 0
            self.tableview.reloadData()
            
        }
        DataManager.shareInstance.getDetailSong(stringID: (data?.id)!) { (result) in
            
            self.dataSong = result
            self.KEY = 1
            self.tableview.reloadData()
        }
        
    }
    
    
    func showList(){
        print("Show")
        print(data?.category)
        print(data?.price)
        print(data?.id)
    }
    
}

extension DetailView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 150
//        }
//        else{
//            return 1200
//        }
//    }
    
    
    
    
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    
            if indexPath.row == 0 {
                return 150
                
            }else {
                return 1000
            }
            
        }
    
}


extension DetailView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        resultSegment = segmentControl.selectedSegmentIndex
        
        if indexPath.row == 0 {
            if (KEY == 1){
                
                let cell = tableview.dequeueReusableCell(withIdentifier: "CellDetailSong", for: indexPath) as! CellDetailSong
                cell.detailSong = dataSong
                return cell
            }
            
            let cellSlide = tableview.dequeueReusableCell(withIdentifier: "CellSlideApp", for: indexPath) as! CellSlideApp
            cellSlide.loadDetailApp = dataDetail
            return cellSlide
            
          
            
        }else{
            if KEY == 1 {
                let cell = tableview.dequeueReusableCell(withIdentifier: "CellDetailApp", for: indexPath) as! CellDetailApp
                //cell.setupViews = dataDetail
                return cell
            }
          
            
            switch resultSegment {
            case 0:
                let cell = tableview.dequeueReusableCell(withIdentifier: "CellDetailApp", for: indexPath) as! CellDetailApp
                cell.setupViews = dataDetail
              return cell
              
            case 1:
                let cell = tableview.dequeueReusableCell(withIdentifier: "CellDetailApp", for: indexPath) as! CellDetailApp
                cell.setupReview = dataDetail
                return cell
            
            case 2:
                let cell = tableview.dequeueReusableCell(withIdentifier: "CellDetailApp", for: indexPath) as! CellDetailApp
                cell.setupRate = dataDetail
                return cell
            default:
                let cell = tableview.dequeueReusableCell(withIdentifier: "CellDetailApp", for: indexPath) as! CellDetailApp
                cell.setupViews = dataDetail
             return cell
               
            }
            
          
            
            
        }
        
        
    }
}






