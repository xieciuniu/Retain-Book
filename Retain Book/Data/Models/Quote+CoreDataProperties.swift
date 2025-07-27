//
//  Quote+CoreDataProperties.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//
//

import Foundation
import CoreData


extension Quote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quote> {
        return NSFetchRequest<Quote>(entityName: "Quote")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var text: String?
    @NSManaged public var book: Book?

}

extension Quote : Identifiable {

}
