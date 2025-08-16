//
//  Persistence.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 20/07/2025.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newBook = Book(context: viewContext)
            newBook.id = UUID()
            newBook.title = "Sample Book Title \(i)"
            newBook.author = "Author \(i)"
            newBook.totalPage = Int32(200 + i * 10)
            newBook.currentPage = Int32(50 + i * 5)
            newBook.shelfStatus = ShelfStatus.reading.rawValue
            // converting resource .jpg to data object
            if let uiImage = UIImage(named: "exampleCover") {
                let imageData = uiImage.jpegData(compressionQuality: 1.0)
                newBook.coverImageData = imageData
            }
            newBook.dateAdded = Date()
            newBook.dateLastRead = Date().addingTimeInterval(TimeInterval(i * 60))
            newBook.isbn = "978-83-21-12345-6"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Retain_Book")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
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
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
