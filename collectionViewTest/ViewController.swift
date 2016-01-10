//
//  ViewController.swift
//  collectionViewTest
//
//  Created by Ken Pierce on 1/9/16.
//  Copyright © 2016 Ken Pierce. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    var coredatastack = CoreDataStack()
    var theLandsList: [TheLands] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        theLandsList = fetchLands()
        for TheLands in theLandsList{
            print("land name is \(TheLands.lineValue)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
// Getting data for data views
    func fetchLands() -> [TheLands] {

        let landsFetch = NSFetchRequest(entityName: "TheLands")
        var theLands: [TheLands] = []
        do {
            let results = try coredatastack.context.executeFetchRequest(landsFetch) as! [TheLands]
        
            if results.count > 0 {
            theLands = results
        } else {
            
            //insertIntoManagedObjectContext: managedContext) currentDog.name = dogName
            //try managedContext.save()
            }
        } catch let error as NSError {
            print("Error: \(error) " +
            "description \(error.localizedDescription)")
        }
        return theLands
    }
    
//CollectionView stuff
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theLandsList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath)
        let theLabel = cell.viewWithTag(3) as! UILabel
        theLabel.text = theLandsList[indexPath.row].lineValue
        
        return cell
    }
    
    
    
    
//TableView Data source delegates
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return theLandsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCellWithIdentifier("newCell")
                
                let theLabel = cell?.viewWithTag(5) as! UILabel
                theLabel.text = theLandsList[indexPath.row].lineValue
                return cell!
    }
  
    
}

