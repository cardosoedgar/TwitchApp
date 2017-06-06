//
//  CoreData.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStackManager {
    var context:NSManagedObjectContext
    var psc:NSPersistentStoreCoordinator
    var model:NSManagedObjectModel
    var store:NSPersistentStore?
    
    let resource = "TwitchTvApp"
    
    init() {
        let bundle = Bundle.main
        let modelURL =
        bundle.url(forResource: resource , withExtension:"momd")
        model = NSManagedObjectModel(contentsOf: modelURL!)!
        
        psc = NSPersistentStoreCoordinator(managedObjectModel:model)
        
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        
        let documentsURL = applicationDocumentsDirectory()
        let storeURL =
        documentsURL.appendingPathComponent("twitchtvapp")
        
        let options =
        [NSMigratePersistentStoresAutomaticallyOption: true]
        
        do {
            store = try psc.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: storeURL,
            options: options)
        } catch let error as NSError {
            print("Error adding persistent store: \(error)")
            abort()
        }
        
    }
    
    func saveContext() {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    func applicationDocumentsDirectory() -> NSURL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        return urls[0] as NSURL
    }
}
