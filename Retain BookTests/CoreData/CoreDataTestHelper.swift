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
        let container = NSPersistentContainer(name: "Retain_Book")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        description.setOption(nil, forKey: "NSPersistentStoreCloudKitContainerIdentifier")

        
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
        // For in-memory stores, we need to manually delete objects instead of using NSBatchDeleteRequest
        
        // Delete all chapters first (due to relationships)
        let chapterFetchRequest: NSFetchRequest<NSFetchRequestResult> = Chapter.fetchRequest()
        do {
            let chapters = try context.fetch(chapterFetchRequest) as! [Chapter]
            for chapter in chapters {
                context.delete(chapter)
            }
        } catch {
            print("Failed to fetch chapters for deletion: \(error)")
        }
        
        // Delete all books
        let bookFetchRequest: NSFetchRequest<NSFetchRequestResult> = Book.fetchRequest()
        do {
            let books = try context.fetch(bookFetchRequest) as! [Book]
            for book in books {
                context.delete(book)
            }
        } catch {
            print("Failed to fetch books for deletion: \(error)")
        }
        
        // Save changes
        do {
            try context.save()
        } catch {
            print("Failed to reset test data: \(error)")
        }
    }
}
