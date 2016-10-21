//
//  TabTopMovies.swift
//  AppStore
//
//  Created by ReasonAmu on 10/18/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher

class TabTopMovies: UIViewController,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var segmentTabMovie: UISegmentedControl!
    
    var listMovies = [Entry]()
    var listTVSeasons = [Entry]()
    var listTVEpisodes = [Entry]()
    var resultSegment: Int = 0
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CellMovies", bundle: nil), forCellWithReuseIdentifier: "CellMovies")
        
       
        
        
        
        let segmentMovie = ["Top Movies", "Top TV Seasons", "Top TV Episodes"]
        initSegmentControl(listSegment: segmentMovie)
        loadData()
        
    }
    
    
    
    func loadData(){
        DataManager.shareInstance.getTopMovies { (api) in
            self.listMovies = api.entry!
            self.navigationItem.title = api.title
            self.collectionView.reloadData()
        }
        DataManager.shareInstance.getTopSeasons { (api) in
            self.listTVSeasons = api.entry!
            self.navigationItem.title = api.title
            self.collectionView.reloadData()
        }
        DataManager.shareInstance.getTopEpisodes { (api) in
            self.listTVEpisodes = api.entry!
            self.navigationItem.title = api.title
            self.collectionView.reloadData()
        }
    }
    
    func initSegmentControl(listSegment : [String]){
        
        segmentTabMovie.removeAllSegments() //-- remove segment title
        for (index,item) in listSegment.enumerated() {
            segmentTabMovie.insertSegment(withTitle: item, at: index, animated: false)
        }
        segmentTabMovie.selectedSegmentIndex = 0 //-- set default is index = 0
        segmentTabMovie.addTarget(self, action: #selector(actionSegmentControl), for: .allEvents)
    }
    
    
    func actionSegmentControl(){
        collectionView.reloadData()
        
    }


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/4, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
  
}


extension TabTopMovies : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        resultSegment = segmentTabMovie.selectedSegmentIndex
        switch resultSegment {
        case 0:
            let stringURL = listMovies[indexPath.row].image
            let url = URL(string: stringURL!)!
            (cell as! CellMovies).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
            (cell as! CellMovies).name.text = listMovies[indexPath.item].name
        case 1:
            let stringURL = listTVSeasons[indexPath.row].image
            let url = URL(string: stringURL!)!
            (cell as! CellMovies).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
            (cell as! CellMovies).name.text = listTVSeasons[indexPath.item].name
        case 2:
            let stringURL = listTVEpisodes[indexPath.row].image
            let url = URL(string: stringURL!)!
            (cell as! CellMovies).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
            (cell as! CellMovies).name.text = listTVEpisodes[indexPath.item].name
        default:
            break
        }
        
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "detailview") as! DetailView
        resultSegment = segmentTabMovie.selectedSegmentIndex
        switch resultSegment {
        case 0:
            detailView.data = listMovies[indexPath.item]
            detailView.title = listMovies[indexPath.item].name
        case 1:
            detailView.data = listTVSeasons[indexPath.item]
            detailView.title = listTVSeasons[indexPath.item].name
        case 2:
            detailView.data = listTVEpisodes[indexPath.item]
            detailView.title = listTVEpisodes[indexPath.item].name
        default:
            break
        }
        
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    
    
}

extension TabTopMovies : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMovies", for: indexPath) as! CellMovies
        cell.imageViews.kf.indicatorType = .activity
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultSegment = segmentTabMovie.selectedSegmentIndex
        switch resultSegment {
        case 0:
            return listMovies.count
            
        case 1:
            return listTVSeasons.count
            
        case 2:
            return listTVEpisodes.count
            
        default:
            return listMovies.count
        }
 
        
    }
}
