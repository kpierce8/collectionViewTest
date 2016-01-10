//
//  AppDelegate.swift
//  collectionViewTest
//
//  Created by Ken Pierce on 1/9/16.
//  Copyright © 2016 Ken Pierce. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let coredatastack = CoreDataStack()
    let dataImporter = LTDILImporter()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
    
        dataImporter.importJSONSeedData()
        
        return true
    }

   

    
    
    

}

