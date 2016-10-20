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
    var listMovies = [Entry]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CellMovies", bundle: nil), forCellWithReuseIdentifier: "CellMovies")
        
        DataManager.shareInstance.getTopMovies { (api) in
            self.listMovies = api.entry!
            self.navigationItem.title = api.title
            self.collectionView.reloadData()
        }
        
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
        let stringURL = listMovies[indexPath.row].image
        let url = URL(string: stringURL!)!
        (cell as! CellMovies).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
        (cell as! CellMovies).name.text = listMovies[indexPath.item].name
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! CellMovies).imageViews.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "detailview") as! DetailView
            detailView.data = listMovies[indexPath.item]
            detailView.title = listMovies[indexPath.item].name
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
        return listMovies.count
    }
}
