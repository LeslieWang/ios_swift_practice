//
//  MoreViewController.swift
//  FoodPin
//
//  Created by leslie on 6/8/15.
//  Copyright (c) 2015 leslie. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    @IBOutlet var imageVieW:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageVieW.image = getUIImageFromWeb("http://pic10.nipic.com/20101019/5891522_212906680000_2.jpg")
    }
    
    func getUIImageFromWeb(urlStr:String) -> UIImage? {
        if let imageUrl = NSURL(string: urlStr) {
            if let nsdata = NSData(contentsOfURL: imageUrl) {
                return UIImage(data: nsdata)
            }
        }
        return nil
    }
}
