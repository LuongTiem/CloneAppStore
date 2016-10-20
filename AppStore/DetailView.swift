//
//  DetailView.swift
//  AppStore
//
//  Created by ReasonAmu on 10/19/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class DetailView: UIViewController {
    var data: Entry?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showList))
    }


    func showList(){
        print("Show")
        print(data?.category)
        print(data?.price)
        print(data?.id)
    }
}
