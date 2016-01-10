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
    
    
    func createFirstVisit() {
        
         var error: NSError? = nil
        
        let visitEntity = NSEntityDescription.entityForName("visitData", inManagedObjectContext: coreDataStack.context)
        let playerEntity = NSEntityDescription.entityForName("players", inManagedObjectContext: coreDataStack.context)
        
        
        let visit = visitData(entity: visitEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        visit.visitName = "FirstVisit"
        visit.creationDate = NSDate()
        
        let player1 = players(entity: playerEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        player1.player = "PressMe1"
        player1.playerOrder = 1
        player1.visitID = visit
        
        let player2 = players(entity: playerEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        player2.player = "PressMe2"
        player2.playerOrder = 2
 player2.visitID = visit
        
        let player3 = players(entity: playerEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        player3.player = "PressMe3"
        player3.playerOrder = 3
 player3.visitID = visit
        
        let player4 = players(entity: playerEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        player4.player = "PressMe4"
        player4.playerOrder = 4
 player4.visitID = visit
        
        let thePlayers: [players] = [player1, player2, player3, player4]
        
       // thePlayers.append(<#newElement: players#>) )
        
        visit.players   = NSSet(array: thePlayers)
        
        coreDataStack.saveContext()
        
        let userDef = NSUserDefaults.standardUserDefaults()
        userDef.setValue(visit.visitName, forKey: "VisitID")

    }
    
    

func importJSONSeedData() {
    
    var error: NSError? = nil
    
    let rideEntity = NSEntityDescription.entityForName("TheRides", inManagedObjectContext: coreDataStack.context)
    let questionEntity = NSEntityDescription.entityForName("TheQuestions", inManagedObjectContext: coreDataStack.context)
    let landEntity = NSEntityDescription.entityForName("TheLands", inManagedObjectContext: coreDataStack.context)
    let parkEntity = NSEntityDescription.entityForName("TheParks", inManagedObjectContext: coreDataStack.context)
    let answerEntity = NSEntityDescription.entityForName("TheAnswers", inManagedObjectContext: coreDataStack.context)
    let sectionEntity = NSEntityDescription.entityForName("TheSections", inManagedObjectContext: coreDataStack.context)
    let faqEntity = NSEntityDescription.entityForName("TheFAQ", inManagedObjectContext: coreDataStack.context)
    let collectionEntity = NSEntityDescription.entityForName("TheCollections", inManagedObjectContext: coreDataStack.context)
    
    
    //MARK import TheRides
    let ridesURL = NSBundle.mainBundle().URLForResource("theRides", withExtension: "json")
    let ridesData = NSData(contentsOfURL: ridesURL!)
    let ridesDict = NSJSONSerialization.JSONObjectWithData(ridesData!, options: nil, error: &error) as! NSDictionary
    let ridesArray = ridesDict["theRides"] as! [NSDictionary]
    for ridesDictionary in ridesArray {
        
        let questionID = ridesDictionary.valueForKeyPath("questionID") as? NSString
        let landID = ridesDictionary.valueForKeyPath("landID") as? NSString
        let rideID = ridesDictionary.valueForKeyPath("rideID") as? NSString
        let lineValue = ridesDictionary.valueForKeyPath("lineValue") as? NSString
        let questionType = ridesDictionary.valueForKeyPath("questionType") as? NSString
        
        
        let ride = TheRides(entity: rideEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        ride.questionID = questionID!.integerValue
        ride.questionType = questionType!.integerValue
        ride.lineValue = lineValue! as String
        ride.rideID = rideID!.integerValue
        ride.landID = landID!.integerValue
    }
    
    
    //MARK import TheLands
    let landsURL = NSBundle.mainBundle().URLForResource("theLands", withExtension: "json")
    let landsData = NSData(contentsOfURL: landsURL!)
    let landsDict = NSJSONSerialization.JSONObjectWithData(landsData!, options: nil, error: &error) as! NSDictionary
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
    
    //MARK import TheParks
    let parksURL = NSBundle.mainBundle().URLForResource("theParks", withExtension: "json")
    let parksData = NSData(contentsOfURL: parksURL!)
    let parksDict = NSJSONSerialization.JSONObjectWithData(parksData!, options: nil, error: &error) as! NSDictionary
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
    
    //MARK import TheQuestions
    let questionsURL = NSBundle.mainBundle().URLForResource("theQuestions", withExtension: "json")
    let questionsData = NSData(contentsOfURL: questionsURL!)
    let questionsDict = NSJSONSerialization.JSONObjectWithData(questionsData!, options: nil, error: &error) as! NSDictionary
    let questionsArray = questionsDict["theQuestions"]as! [NSDictionary]
    for questionsDictionary in questionsArray {
        
        let questionID = questionsDictionary.valueForKeyPath("questionID") as? NSNumber
        let landID2 = questionsDictionary.valueForKeyPath("landID") as? NSNumber
        let rideID2 = questionsDictionary.valueForKeyPath("rideID") as? NSNumber
        let lineValue = questionsDictionary.valueForKeyPath("lineValue") as? NSString
        let questionType = questionsDictionary.valueForKeyPath("questionType") as? NSString
        
        
        let question = TheQuestions(entity: questionEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        question.questionID = questionID!
        question.questionType = questionType!.integerValue
        question.lineValue = lineValue! as String
        question.rideID = rideID2!
        question.landID = landID2!
    }
    
    //MARK import TheAnswers
    let answersURL = NSBundle.mainBundle().URLForResource("theAnswers", withExtension: "json")
    let answersData = NSData(contentsOfURL: answersURL!)
    let answersDict = NSJSONSerialization.JSONObjectWithData(answersData!, options: nil, error: &error)as! NSDictionary
    let answersArray = answersDict["theAnswers"] as! [NSDictionary]
    for answersDictionary in answersArray {
        
        let answerID = answersDictionary.valueForKeyPath("answerID") as? NSString
        let landID2 = answersDictionary.valueForKeyPath("landID") as? NSString
        let rideID2 = answersDictionary.valueForKeyPath("rideID") as? NSNumber
        let lineValue = answersDictionary.valueForKeyPath("lineValue") as? NSString
        let questionType = answersDictionary.valueForKeyPath("questionType") as? NSString
        let questionID = answersDictionary.valueForKeyPath("questionID") as? NSNumber
        let isCorrect = answersDictionary.valueForKeyPath("isCorrect") as? NSString
        
        let answer = TheAnswers(entity: answerEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        answer.questionID = questionID!
        answer.questionType = questionType!.integerValue
        answer.lineValue = lineValue! as String
        answer.rideID = rideID2!
        answer.landID = landID2!.integerValue
        answer.answerID = answerID!.integerValue
        answer.isCorrect = isCorrect! as String
    }
    
    //MARK import TheSections
    let sectionsURL = NSBundle.mainBundle().URLForResource("theSections", withExtension: "json")
    let sectionsData = NSData(contentsOfURL: sectionsURL!)
    let sectionsDict = NSJSONSerialization.JSONObjectWithData(sectionsData!, options: nil, error: &error) as! NSDictionary
    let sectionsArray = sectionsDict["theSections"] as! [NSDictionary]
    for sectionsDictionary in sectionsArray {
        
        let sectionID = sectionsDictionary.valueForKeyPath("sectionID") as? NSNumber
        let endID = sectionsDictionary.valueForKeyPath("endID") as? NSNumber
        let rideID2 = sectionsDictionary.valueForKeyPath("rideID") as? NSNumber
        let sectionTitle = sectionsDictionary.valueForKeyPath("sectionTitle") as? NSString
        let sectionText = sectionsDictionary.valueForKeyPath("sectionText") as? NSString
        let questionType = sectionsDictionary.valueForKeyPath("questionType") as? NSString
        let startID = sectionsDictionary.valueForKeyPath("startID") as? NSNumber
        
        let section = TheSections(entity: sectionEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        section.startID = startID!
        section.sectionTitle = sectionTitle!as String
        section.sectionText = sectionText! as String
        section.rideID = rideID2!
        section.endID = endID!
        section.sectionID = sectionID!
        
    }
    
    //MARK import TheCollections
    let collectionsURL = NSBundle.mainBundle().URLForResource("theCollections", withExtension: "json")
    let collectionsData = NSData(contentsOfURL: collectionsURL!)
    let collectionsDict = NSJSONSerialization.JSONObjectWithData(collectionsData!, options: nil, error: &error) as! NSDictionary
    let collectionsArray = collectionsDict["theCollections"] as! [NSDictionary]
    
    for collectionsDictionary in collectionsArray {
        
        let collectionTitle = collectionsDictionary.valueForKeyPath("collectionTitle") as? NSString
        let questionID = collectionsDictionary.valueForKeyPath("questionID") as? NSNumber
        let collectionText = collectionsDictionary.valueForKeyPath("collectionText") as? NSString
        
        
        
        let collection = TheCollections(entity: collectionEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        if collectionText != nil {
        collection.collectionText = collectionText as? String
        }
        collection.collectionTitle = collectionTitle as! String
        collection.questionID = questionID!
        
    }
    
    //MARK import TheFAQ
    let faqsURL = NSBundle.mainBundle().URLForResource("theFAQ", withExtension: "json")
    let faqsData = NSData(contentsOfURL: faqsURL!)
    let faqsDict = NSJSONSerialization.JSONObjectWithData(faqsData!, options: nil, error: &error) as! NSDictionary
    let faqsArray = faqsDict["theFAQ"] as! [NSDictionary]
    
    for faqsDictionary in faqsArray {
        
        let question = faqsDictionary.valueForKeyPath("question") as? NSString
        let answer = faqsDictionary.valueForKeyPath("answer") as? NSString
        
        
        
        let faq = TheFAQ(entity: faqEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        faq.answer = answer! as String
        faq.question = question! as String
        
    }
    
    
    coreDataStack.saveContext()
}
}