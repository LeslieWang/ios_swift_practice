//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by leslie on 6/4/15.
//  Copyright (c) 2015 leslie. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    @IBOutlet var headingLabel:UILabel!
    @IBOutlet var subLabel:UILabel!
    @IBOutlet var imageView:UIImageView!
    
    var index = 0
    var heading = ""
    var image = ""
    var subHead = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        subLabel.text = subHead
        imageView.image = UIImage(named: image)
    }
}
