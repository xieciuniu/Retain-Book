//
//  CoreDataService.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation
import CoreData

class CoreDataService: DataService {
    func editBook(id: Int32, title: String?, author: String?, totalPages: Int32?) {
        <#code#>
    }
    
    func deleteBook(id: Int) {
        <#code#>
    }
    
    func fetchBooks() -> [Book] {
        <#code#>
    }
    
    func fetchBook(id: UUID) -> Book {
        <#code#>
    }
    
    func addCategory() {
        <#code#>
    }
    
    func addKnowledgeItem() {
        <#code#>
    }
    
    func deleteKnowledgeItem() {
        <#code#>
    }
    
    func editKnowledgeItem() {
        <#code#>
    }
    
    func fetchKnowledgeItems() -> [KnowledgeItem] {
        <#code#>
    }
    
    func setNextReviewDate() {
        <#code#>
    }
    
    func setEaseFactor() {
        <#code#>
    }
    
    func addQuote() {
        <#code#>
    }
    
    func deleteQuote() {
        <#code#>
    }
    
    func editQuote() {
        <#code#>
    }
    
    func fetchQuotes() -> [Quote] {
        <#code#>
    }
    
    func addReadingGoal() {
        <#code#>
    }
    
    func deleteReadingGoal() {
        <#code#>
    }
    
    func editReadingGoal() {
        <#code#>
    }
    
    func fetchReadingGoals() -> [ReadingGoal] {
        <#code#>
    }
    
    func addReadingLog() {
        <#code#>
    }
    
    func deleteReadingLog() {
        <#code#>
    }
    
    func editReadingLog() {
        <#code#>
    }
    
    func fetchReadingLogs() -> [ReadingLog] {
        <#code#>
    }
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
//    func addBook(title: String, author: String, totalPages: Int32)
}
