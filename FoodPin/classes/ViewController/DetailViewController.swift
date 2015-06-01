//
//  DetailViewController.swift
//  FoodPin
//
//  Created by leslie on 6/1/15.
//  Copyright (c) 2015 leslie. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // disable auto hide navigation bar while swipe list.
        navigationController?.hidesBarsOnSwipe = false
        
        // set teh title of this page
        title = "Detail"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
