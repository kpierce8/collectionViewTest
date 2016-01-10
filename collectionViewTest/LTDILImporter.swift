//
//  LTDILImporter.swift
//  coreDataTest
//
//  Created by Ken Pierce on 1/19/15.
//  Copyright (c) 2015 Ken Pierce. All rights reserved.
//

import Foundation
import CoreData

class LTDILImporter {

lazy var coreDataStack = CoreDataStack()

    init() {

    }
    
    
    
    

func importJSONSeedData() {
    



    let landEntity = NSEntityDescription.entityForName("TheLands", inManagedObjectContext: coreDataStack.context)
    let parkEntity = NSEntityDescription.entityForName("TheParks", inManagedObjectContext: coreDataStack.context)

    
    
    
   
    //MARK import TheLands
    let landsURL = NSBundle.mainBundle().URLForResource("theLands", withExtension: "json")
    let landsData = NSData(contentsOfURL: landsURL!)
    
    do{
        let landsDict = try NSJSONSerialization.JSONObjectWithData(landsData!, options: .AllowFragments) as!NSDictionary
        let landsArray = landsDict["theLands"] as! [NSDictionary]
        for landsDictionary in landsArray {
            let landID = landsDictionary.valueForKeyPath("landID") as? NSString
            let parkID = landsDictionary.valueForKeyPath("parkID") as? NSString
            let lineValue = landsDictionary.valueForKeyPath("lineValue") as? NSString
            
            let land = TheLands(entity: landEntity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            land.lineValue = lineValue! as String
            land.parkID = parkID!.integerValue
            land.landID = landID!.integerValue
            
        }
    
    
    } catch let error as NSError {
        print("could not fetch \(error)")
    }
    
    
    
    

    
    //MARK import TheParks
    let parksURL = NSBundle.mainBundle().URLForResource("theParks", withExtension: "json")
    let parksData = NSData(contentsOfURL: parksURL!)

    do{
            let parksDict = try NSJSONSerialization.JSONObjectWithData(parksData!, options: .AllowFragments) as! NSDictionary
    let parksArray = parksDict["theParks"] as! [NSDictionary]
    
    for parksDictionary in parksArray {
        
        let pname = parksDictionary.valueForKeyPath("name") as? NSString
        let parkID2 = parksDictionary.valueForKeyPath("parkID") as? NSNumber
        let nick = parksDictionary.valueForKeyPath("nick") as? NSString
        let scavengerID = parksDictionary.valueForKeyPath("scavengerID") as? NSNumber
        
        
        let park = TheParks(entity: parkEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        park.name = pname! as String
        park.parkID = parkID2!
        park.nick = nick! as String
        park.scavengerID = scavengerID!
    }
    }catch let error as NSError {
        print("could not fetch \(error)")
    }

    
    
    coreDataStack.saveContext()
}
}