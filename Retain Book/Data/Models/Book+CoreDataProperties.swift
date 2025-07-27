//
//  Book+CoreDataProperties.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var currentPage: Int32
    @NSManaged public var dateFinished: Date?
    @NSManaged public var dateLastRead: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var shelfStatus: String?
    @NSManaged public var title: String?
    @NSManaged public var totalPage: Int32
    @NSManaged public var categories: NSSet?
    @NSManaged public var knowledgeItem: NSSet?
    @NSManaged public var quotes: NSSet?
    @NSManaged public var readingLogs: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for categories
extension Book {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

// MARK: Generated accessors for knowledgeItem
extension Book {

    @objc(addKnowledgeItemObject:)
    @NSManaged public func addToKnowledgeItem(_ value: KnowledgeItem)

    @objc(removeKnowledgeItemObject:)
    @NSManaged public func removeFromKnowledgeItem(_ value: KnowledgeItem)

    @objc(addKnowledgeItem:)
    @NSManaged public func addToKnowledgeItem(_ values: NSSet)

    @objc(removeKnowledgeItem:)
    @NSManaged public func removeFromKnowledgeItem(_ values: NSSet)

}

// MARK: Generated accessors for quotes
extension Book {

    @objc(addQuotesObject:)
    @NSManaged public func addToQuotes(_ value: Quote)

    @objc(removeQuotesObject:)
    @NSManaged public func removeFromQuotes(_ value: Quote)

    @objc(addQuotes:)
    @NSManaged public func addToQuotes(_ values: NSSet)

    @objc(removeQuotes:)
    @NSManaged public func removeFromQuotes(_ values: NSSet)

}

// MARK: Generated accessors for readingLogs
extension Book {

    @objc(addReadingLogsObject:)
    @NSManaged public func addToReadingLogs(_ value: ReadingLog)

    @objc(removeReadingLogsObject:)
    @NSManaged public func removeFromReadingLogs(_ value: ReadingLog)

    @objc(addReadingLogs:)
    @NSManaged public func addToReadingLogs(_ values: NSSet)

    @objc(removeReadingLogs:)
    @NSManaged public func removeFromReadingLogs(_ values: NSSet)

}

extension Book : Identifiable {

}
