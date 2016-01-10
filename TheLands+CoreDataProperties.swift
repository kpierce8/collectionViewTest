//
//  TheLands+CoreDataProperties.swift
//  collectionViewTest
//
//  Created by Ken Pierce on 1/9/16.
//  Copyright © 2016 Ken Pierce. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TheLands {

    @NSManaged var landID: NSNumber?
    @NSManaged var parkID: NSNumber?
    @NSManaged var lineValue: String?

}
