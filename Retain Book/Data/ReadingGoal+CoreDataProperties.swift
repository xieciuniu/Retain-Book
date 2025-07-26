//
//  ReadingGoal+CoreDataProperties.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//
//

import Foundation
import CoreData


extension ReadingGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReadingGoal> {
        return NSFetchRequest<ReadingGoal>(entityName: "ReadingGoal")
    }

    @NSManaged public var goalType: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var user: User?

}

extension ReadingGoal : Identifiable {

}
