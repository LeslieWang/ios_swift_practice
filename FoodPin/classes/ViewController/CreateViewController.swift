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
            errorStr = "Missing name field."
        } else if typeText.text == "" {
            errorStr = "Missing type field."
        } else if locationText.text == "" {
            errorStr = "Missing location field."
        } else if !setImage {
            errorStr = "Missing image."
        }
        
        if errorStr != "" {
            let alertController = UIAlertController(title: "Oops", message: errorStr, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
