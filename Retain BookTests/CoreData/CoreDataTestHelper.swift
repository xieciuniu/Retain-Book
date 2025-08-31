//
//  CoreDataTestHelper.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 31/08/2025.
//

import Foundation
import CoreData
@testable import Retain_Book

class CoreDataTestHelper {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RetainBook")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Faield to load Core Data stack: \(error)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Failed to save test context: \(error)")
        }
    }
    
    func reset() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Faield to reset test data: \(error)")
        }
    }
}
