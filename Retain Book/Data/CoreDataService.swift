//
//  CoreDataService.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation
import CoreData

class CoreDataService: DataService {
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
//    func addBook(title: String, author: String, totalPages: Int32)
}
