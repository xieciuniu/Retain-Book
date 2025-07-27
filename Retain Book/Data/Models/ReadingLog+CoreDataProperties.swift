//
//  ReadingLog+CoreDataProperties.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//
//

import Foundation
import CoreData


extension ReadingLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReadingLog> {
        return NSFetchRequest<ReadingLog>(entityName: "ReadingLog")
    }

    @NSManaged public var date: Date?
    @NSManaged public var endPage: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var pagesRead: Int32
    @NSManaged public var book: Book?

}

extension ReadingLog : Identifiable {

}
