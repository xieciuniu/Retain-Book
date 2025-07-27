//
//  User+CoreDataProperties.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var dailyPageGoal: String?
    @NSManaged public var name: String?
    @NSManaged public var books: NSSet?
    @NSManaged public var categories: NSSet?
    @NSManaged public var readingGoals: NSSet?

}

// MARK: Generated accessors for books
extension User {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

// MARK: Generated accessors for categories
extension User {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

// MARK: Generated accessors for readingGoals
extension User {

    @objc(addReadingGoalsObject:)
    @NSManaged public func addToReadingGoals(_ value: ReadingGoal)

    @objc(removeReadingGoalsObject:)
    @NSManaged public func removeFromReadingGoals(_ value: ReadingGoal)

    @objc(addReadingGoals:)
    @NSManaged public func addToReadingGoals(_ values: NSSet)

    @objc(removeReadingGoals:)
    @NSManaged public func removeFromReadingGoals(_ values: NSSet)

}

extension User : Identifiable {

}
