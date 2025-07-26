//
//  Category+CoreDataProperties.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var books: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for books
extension Category {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension Category : Identifiable {

}
