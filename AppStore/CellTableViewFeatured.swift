//
//  CellTableViewFeatured.swift
//  AppStore
//
//  Created by ReasonAmu on 10/18/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher


protocol PushDetailDelegate {
    func pushDetail(entry : Entry, title : String)
}


class CellTableViewFeatured: UITableViewCell {
    
    var setUpTableCell : CallAPI? {
        
        didSet{
            
            setup()
            title.text =  setUpTableCell?.title
            collectionView.reloadData()
            
           
        }
    }
    
    var delegates : PushDetailDelegate!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        collectionView.register(UINib(nibName: "CellFeatured", bundle: nil), forCellWithReuseIdentifier: "CellFeatured")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    
}


extension CellTableViewFeatured : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
}

extension CellTableViewFeatured : UICollectionViewDataSource,UICollectionViewDataSourcePrefetching {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellFeatured", for: indexPath) as! CellFeatured
        cell.imageViews.kf.indicatorType = .activity
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]){
        var urls = [URL]()
        
        for indexPath in indexPaths {
            let url = URL(string: (setUpTableCell?.entry?[indexPath.row].image)!)!
            urls.append(url)
        }
        ImagePrefetcher(urls: urls).start()
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = setUpTableCell?.entry?.count{
            return count
        }
        
        return 0
        
    }
    
}

extension CellTableViewFeatured : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! CellFeatured).setUpCell =  setUpTableCell?.entry?[indexPath.item]
        
        let stringURL = setUpTableCell?.entry?[indexPath.item].image
        let url = URL(string: stringURL!)!
        (cell as! CellFeatured).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! CellFeatured).imageViews.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        delegates.pushDetail(entry: (setUpTableCell?.entry?[indexPath.item])! , title: (setUpTableCell?.entry?[indexPath.item].name!)!)
        
        
    }
}
