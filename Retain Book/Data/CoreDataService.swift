//
//  CoreDataService.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation
import CoreData

class CoreDataService: DataService {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addBook(title: String, author: String, totalPages: Int32) {
        let newBook = Book(context: context)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.totalPage = totalPages
        
        do {
            try context.save()
        } catch {
            print("Failed to save book: \(error)")
        }
    }
}
