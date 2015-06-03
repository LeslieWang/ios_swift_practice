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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        // disable auto hide navigation bar while swipe list.
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // cancel selection while clicking on detail view cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        // this one is better than the above one
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DetailViewCell = tableView.dequeueReusableCellWithIdentifier("detailCell") as! DetailViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = NSLocalizedString("Name", comment:"Restaurant name")
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = NSLocalizedString("Type", comment:"Restaurant type")
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = NSLocalizedString("Location", comment:"Restaurant location")
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = NSLocalizedString("Been Here", comment:"")
            cell.valueLabel.text = restaurant.visited.boolValue ? NSLocalizedString("Yes, I've been here before", comment:"") : NSLocalizedString("No", comment:"Not been here")
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        // set cell transparent
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
}
