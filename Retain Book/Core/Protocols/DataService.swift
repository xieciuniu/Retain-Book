//
//  DataService.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation

protocol DataService {
    // MARK: Books Entitie
    func addBook(title: String, author: String, totalPages: Int32)
    func editBook(id: Int32, title: String?, author: String?, totalPages: Int32?)
    func deleteBook(id: Int)
    func fetchBooks() -> [Book]
    func fetchBook(id: UUID) -> Book
    
    // MARK: Category Entitie
    func addCategory()
    
    // MARK: KnowledgeItem
    func addKnowledgeItem()
    func deleteKnowledgeItem()
    func editKnowledgeItem()
    func fetchKnowledgeItems() -> [KnowledgeItem]
    func setNextReviewDate()
    func setEaseFactor()
    
    // MARK: Quote
    func addQuote()
    func deleteQuote()
    func editQuote()
    func fetchQuotes() -> [Quote]
    
    // MARK: Reading Goal
    func addReadingGoal()
    func deleteReadingGoal()
    func editReadingGoal()
    func fetchReadingGoals() -> [ReadingGoal]
    
    // MARK: Reading Log
    func addReadingLog()
    func deleteReadingLog()
    func editReadingLog()
    func fetchReadingLogs() -> [ReadingLog]
}
