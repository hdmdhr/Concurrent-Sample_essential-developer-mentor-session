//
//  CoreDataStack.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-19.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let `default`: CoreDataStack = .init(inMemory: false)
    static let test: CoreDataStack = .init(inMemory: true)
    
    internal init(inMemory: Bool) {
        self.inMemory = inMemory
    }
    
    
    private let inMemory: Bool
    
    private(set) lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Data")
        
//        guard let description = container.persistentStoreDescriptions.first else {
//            fatalError("Failed to retrieve a persistent store description.")
//        }

        if inMemory {
//            description.url = URL(fileURLWithPath: "/dev/null")
            
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    
    private(set) lazy var viewContext: NSManagedObjectContext = container.viewContext
    
    
    // MARK: - API
    
    func newBackgroundContext() -> NSManagedObjectContext {
        container.newBackgroundContext()
    }
    
    
    func batchDelete(on moc: NSManagedObjectContext, fetchRequest: NSFetchRequest<NSFetchRequestResult>) throws {
        try moc.batchDeleteAndMergeChanges(fetchRequest: fetchRequest)
    }
    
    
}
