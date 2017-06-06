//
//  CoreDataHelper.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 05/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import CoreData

@testable import TwitchTvApp

extension CoreDataStackManager {
    class func mockManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let concurrencyType = NSManagedObjectContextConcurrencyType(rawValue: 1)
        let managedObjectContext = NSManagedObjectContext(concurrencyType: concurrencyType!)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
}
