//
//  KnowledgeItem+CoreDataProperties.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//
//

import Foundation
import CoreData


extension KnowledgeItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KnowledgeItem> {
        return NSFetchRequest<KnowledgeItem>(entityName: "KnowledgeItem")
    }

    @NSManaged public var answerText: String?
    @NSManaged public var chapterTitle: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var itemType: String?
    @NSManaged public var nextReviewDate: Date?
    @NSManaged public var noteBody: String?
    @NSManaged public var noteTitle: String?
    @NSManaged public var questionText: String?
    @NSManaged public var srsEaseFactor: Double
    @NSManaged public var srsInterval: Double
    @NSManaged public var book: Book?

}

extension KnowledgeItem : Identifiable {

}
