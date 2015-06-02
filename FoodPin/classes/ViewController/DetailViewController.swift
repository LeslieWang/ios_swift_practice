//
//  DetailViewController.swift
//  FoodPin
//
//  Created by leslie on 6/1/15.
//  Copyright (c) 2015 leslie. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    @IBOutlet var restaurantImage:UIImageView!
    
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // disable auto hide navigation bar while swipe list.
        navigationController?.hidesBarsOnSwipe = false
        
        // set teh title of this page
        title = restaurant.name
        
        // set the image of the restaurant
        restaurantImage.image = UIImage(data: restaurant.image)
        
        // set cell dividers invisible
        tableView.separatorColor = UIColor.clearColor()
        
        // set area of non-cell invisible
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        // set table cell flexible in vertical
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DetailViewCell = tableView.dequeueReusableCellWithIdentifier("detailCell") as! DetailViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Been Here"
            cell.valueLabel.text = restaurant.visited.boolValue ? "Yes, I've been here before" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        // set cell transparent
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
}
