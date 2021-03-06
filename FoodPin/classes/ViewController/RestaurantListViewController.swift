//
//  RestaurantListViewController.swift
//  FoodPin
//
//  Created by leslie on 5/28/15.
//  Copyright (c) 2015 leslie. All rights reserved.
//

import UIKit
import CoreData

class RestaurantListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var restaurants:[Restaurant] = []
    var fetchController:NSFetchedResultsController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        // start splash page if first launch app
        if !defaults.boolForKey("hasViewedWelcome") {
            if let splashController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
                self.presentViewController(splashController, animated: true, completion: nil)
            }
        }
        
        // set table cell flexible in vertical
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // reset default back button in this flow.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
            target: nil, action: nil)
        
        // set area of non-cell invisible
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        loadRecords()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // auto hide navigation bar while swipe list.
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RestaurantCell
        
        var restaurant:Restaurant = restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.thumbnailImageView.image = UIImage(data: restaurant.image)
        cell.favorIconImageView.hidden = !restaurant.visited.boolValue
        
        // set circle image
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true

        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // ***add this func to enbale 'swipe' feature***
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle:
        UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // the following 3 functions are the interfaces of NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    // on receive data change invent
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let index = newIndexPath {
                tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Fade)
            }
        case .Delete:
            if let index = indexPath {
                tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Fade)
            }
        case .Update:
            if let index = indexPath {
                tableView.reloadRowsAtIndexPaths([index], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }

        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewDetail" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                var targetController:DetailViewController = segue.destinationViewController as! DetailViewController
                targetController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    // 'swipe' responding actions
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
        
            let shareHandler = {
            (action:UIAlertAction!) -> Void in
                let alertMessage = UIAlertController(title: NSLocalizedString("Oops", comment:"Failed to do something."), message: NSLocalizedString("404 not found, thanks GFW.", comment:"Failed to share"), preferredStyle: .Alert)
                alertMessage.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:"Face the fate"), style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
            }
            let shareMenu = UIAlertController(title: nil, message: NSLocalizedString("Share using", comment:"Share menu title"), preferredStyle: .ActionSheet)
            let twitterAction = UIAlertAction(title: NSLocalizedString("Twitter", comment:""), style: UIAlertActionStyle.Default, handler: shareHandler)
            let facebookAction = UIAlertAction(title: NSLocalizedString("Facebook", comment:""), style: UIAlertActionStyle.Default, handler: shareHandler)
            let emailAction = UIAlertAction(title: NSLocalizedString("Email", comment:""), style: UIAlertActionStyle.Default, handler: shareHandler)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment:""), style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
            }
        )
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: {
            (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in

            // Delete the row from the data source
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
                
                let restaurantToDelete = self.fetchController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                
                var e: NSError?
                if managedObjectContext.save(&e) != true {
                    println("delete error: \(e!.localizedDescription)")
                }
            }
            
        })
        
        deleteAction.backgroundColor = UIColor(red: 237.0/255.0, green: 75.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    @IBAction func cancelFromCreate(segue:UIStoryboardSegue) {
        // add actions while user cancel creating restaurant
        println("user canceled creating restaurant")
    }
    
    @IBAction func savedFromCreate(segue:UIStoryboardSegue) {
        // add actions while user saved a new restaurant
        println("user saved a new restaurant")
    }

    func loadRecords() {
        if let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            var fetchRequest = NSFetchRequest(entityName: "Restaurant")
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
            fetchController.delegate = self
            
            var e:NSError?
            var results = fetchController.performFetch(&e)
            restaurants = fetchController.fetchedObjects as! [Restaurant]
            
            if !results {
                println(e?.localizedDescription)
            }
        }
    }
}
