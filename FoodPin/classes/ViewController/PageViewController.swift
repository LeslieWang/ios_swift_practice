//
//  PageViewController.swift
//  FoodPin
//
//  Created by leslie on 6/4/15.
//  Copyright (c) 2015 leslie. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    var headings = ["Personalize", "Locate", "Discover"]
    var subHeadings = ["Pin your favourite restaurants and create your own food guide",
        "Search and locate your favourite restaurant on Maps",
        "Find restaurants pinned by your friends and other foodies around the world"]
    var images = ["homei", "mapintro", "fiveleaves"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the data source to itself
        dataSource = self
        // Create the first walkthrough screen
        if let startingViewController = self.viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: .Forward, animated: true,
                completion: nil)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        index--
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        index++
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index:Int) -> PageContentViewController? {
        if index < 0 || index >= headings.count || index == NSNotFound {
            return nil
        }
        
        if let controller:PageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController {
            controller.image = images[index]
            controller.heading = headings[index]
            controller.subHead = subHeadings[index]
            controller.index = index
            
            return controller
        }
        return nil
    }
    
    func goNext(index:Int) {
        if let nextPage = viewControllerAtIndex(index + 1) {
            setViewControllers([nextPage], direction: .Forward, animated: true, completion: nil)
        }
    }
}

