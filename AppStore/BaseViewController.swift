//
//  BaseViewController.swift
//  AppStore
//
//  Created by ReasonAmu on 10/20/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    func initSegmentControl(listSegment : [String]){
        
        segmentedControl.removeAllSegments() //-- remove segment title
        for (index,item) in listSegment.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0 //-- set default is index = 0
        segmentedControl.addTarget(self, action: #selector(actionSegmentControl), for: .allEvents)
    }
    
    
    func actionSegmentControl(){
        DispatchQueue.main.async { 
            self.tableview.reloadData()
        }
        
        
    }

}
