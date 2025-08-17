//
//  DataService.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation

protocol DataService {
    // MARK: Books Entitie
    func addBook(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus) -> Book
    func editBook(id: Int32, title: String?, author: String?, totalPages: Int32?)
    func deleteBook(book: Book)
    func handleNewBookWithChapters(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus, chapters: [ChapterPlaceholder])
    
    // MARK: Chapter Entities
    func addChapter(book: Book ,chapters: [ChapterPlaceholder])
    
    
//    // MARK: Category Entitie
//    func addCategory(name: String)
//    func deleteCategory(id: UUID)
//    func editCategory(id: UUID, name: String?)
    
    // MARK: KnowledgeItem
//    func addKnowledgeItem(itemType: String, answerText: String?, questionText: String?, bookId: UUID, chapterTitle: String, noteBody: String?, noteTitle: String?)
//    func deleteKnowledgeItem(id: UUID)
//    func editKnowledgeItem(id: UUID, knowledgeItem: KnowledgeItem)
//    func setNextReviewDate(id: UUID, nextReviewDate: Date)
//    func setEaseFactor(id: UUID, srsEaseFactor: Double)
//    
//    // MARK: Quote
//    func addQuote(book: UUID, text: String)
//    func deleteQuote()
//    func editQuote()
//    
//    // MARK: Reading Goal
//    func addReadingGoal()
//    func deleteReadingGoal()
//    func editReadingGoal()
//    func fetchReadingGoals() -> [ReadingGoal]
//    
    // MARK: Reading Log
//    func addReadingLog()
//    func deleteReadingLog()
//    func editReadingLog()
//    func fetchReadingLogs() -> [ReadingLog]
}
