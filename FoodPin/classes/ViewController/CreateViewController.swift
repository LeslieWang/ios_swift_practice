//
//  CreateViewController.swift
//  FoodPin
//
//  Created by leslie on 6/2/15.
//  Copyright (c) 2015 leslie. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var nameText:UITextField!
    @IBOutlet var typeText:UITextField!
    @IBOutlet var locationText:UITextField!
    @IBOutlet var visitedSegmented:UISegmentedControl!
    
    var setImage = false
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let picker = UIImagePickerController()
                picker.allowsEditing = false
                picker.sourceType = .PhotoLibrary
                picker.delegate = self
                
                presentViewController(picker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        setImage = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // fix status bar bug, status bar style will change to black after displaying the photo library
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    // called while user click save button.
    @IBAction func save() {
        var errorStr = ""
        if nameText.text == "" {
            errorStr = NSLocalizedString("Missing name field.", comment:"")
        } else if typeText.text == "" {
            errorStr = NSLocalizedString("Missing type field.", comment:"")
        } else if locationText.text == "" {
            errorStr = NSLocalizedString("Missing location field.", comment:"")
        } else if !setImage {
            errorStr = NSLocalizedString("Missing image.", comment:"")
        }
        
        if errorStr != "" {
            showAlert(errorStr)
            return
        }
        
        if let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            var restaurant:Restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: moc) as! Restaurant
            restaurant.name = nameText.text
            restaurant.type = typeText.text
            restaurant.location = locationText.text
            restaurant.image = UIImagePNGRepresentation(imageView.image)
            restaurant.visited = visitedSegmented.selectedSegmentIndex == 0

            var e:NSError?
            if !moc.save(&e) {
                println("Failed to insert new restaurant:" + e!.localizedDescription)
                showAlert("Failed to insert new restaurant.")
            } else {
                performSegueWithIdentifier("savedFromCreate", sender: self)
            }
        }
    }
    
    func showAlert(message:String) {
        let alertController = UIAlertController(title: NSLocalizedString("Oops", comment:""), message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment:""), style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}
