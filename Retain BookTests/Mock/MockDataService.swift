//
//  MockDataService.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 31/08/2025.
//

import Foundation
@testable import Retain_Book

class MockDataService: DataService {
    
    // Track method calls for verification
    var addBookCallCount = 0
    var createBookCallCount = 0
    var editBookCallCount = 0
    var deleteBookCallCount = 0
    var handleNewBookAndChaptersCallCount = 0
    var addChapterCallCount = 0
    
    // Store parameters from method calls
    var lastBookTitle: String?
    var lastBookAuthor: String?
    var lastDeletedBook: Book?
    var lastCreatedBook: Book?
    var lastAddedChapters: [ChapterPlaceholder]?
    var lastEditBookId: Int32?
    
    // Control behavior for testing
    var shouldThrowError = false
    var booksToReturn: [Book] = []
    
    // MARK : - DataService Protocol Implementation
    
    func addBook(book: Book) {
        addBookCallCount += 1
        lastCreatedBook = book
    }
    
    func createBook(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus) -> Book {
        createBookCallCount += 1
        lastBookTitle = title
        lastBookAuthor = author
        
        let mockBook = Book()
        mockBook.id = UUID()
        mockBook.title = title
        mockBook.author = author
        mockBook.coverImageData = coverImageData
        if let totalPage { mockBook.totalPage = totalPage }
        if let currentPage { mockBook.currentPage = currentPage }
        mockBook.dateAdded = Date()
        mockBook.dateLastRead = Date()
        if let isbn { mockBook.isbn = isbn }
        mockBook.shelfStatus = shelfStatus.rawValue
        
        booksToReturn.append(mockBook)
        return mockBook
    }
    
    func editBook(id: Int32, title: String?, author: String?, totalPages: Int32?) {
        editBookCallCount += 1
        lastEditBookId = id
        if let title { lastBookTitle = title }
        if let author { lastBookAuthor = author}
    }
    
    func deleteBook(book: Book) {
        deleteBookCallCount += 1
        lastDeletedBook = book
    }
    
    func handleNewBookAndChapters(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus, chapters: [ChapterPlaceholder]) {
        handleNewBookAndChaptersCallCount += 1
        lastBookTitle = title
        lastBookAuthor = author
        lastAddedChapters = chapters
        
        let book = createBook(title: title, author: author, coverImageData: coverImageData, totalPage: totalPage, currentPage: currentPage, isbn: isbn, shelfStatus: shelfStatus)
        addBook(book: book)
        addChapter(book: book, chapters: chapters)
    }
    
    func addChapter(book: Book, chapters: [ChapterPlaceholder]) {
        addChapterCallCount += 1
        lastAddedChapters = chapters
    }
    
    // MARK: - Test Helper Methods
    func reset() {
        addBookCallCount = 0
        createBookCallCount = 0
        editBookCallCount = 0
        deleteBookCallCount = 0
        handleNewBookAndChaptersCallCount = 0
        addChapterCallCount = 0
        
        lastBookTitle = nil
        lastBookAuthor = nil
        lastDeletedBook = nil
        lastCreatedBook = nil
        lastAddedChapters = nil
        lastEditBookId = nil
        
        shouldThrowError = false
        booksToReturn.removeAll()
    }
    
}
