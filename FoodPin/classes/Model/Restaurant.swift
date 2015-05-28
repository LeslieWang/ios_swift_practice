//
//  Restaurant.swift
//  FoodPin
//
//  Created by leslie on 5/28/15.
//  Copyright (c) 2015 leslie. All rights reserved.
//

import Foundation
import CoreData

class Restaurant:NSManagedObject {
    @NSManaged var name:String!
    @NSManaged var type:String!
    @NSManaged var location:String!
    @NSManaged var image:NSData!
    @NSManaged var visited:NSNumber!
}