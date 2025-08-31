//
//  CoreDataServiceTests.swift
//  Retain BookTests
//
//  Created by Hubert Wojtowicz on 31/08/2025.
//

import XCTest
import CoreData
@testable import Retain_Book

class CoreDataServiceTests: XCTestCase {
    
    var coreDataService: CoreDataService!
    var testHelper: CoreDataTestHelper!
    
    override func setUp() {
        super.setUp()
        testHelper = CoreDataTestHelper()
        coreDataService = CoreDataService(context: testHelper.context)
    }
    
    override func tearDown() {
        testHelper.reset()
        coreDataService = nil
        testHelper = nil
        super.tearDown()
    }
    
    // MARK: - Create Book Tests
    
    func testCreateBook_WithAllParameters_CreatesBookCorrectly() {
        // Given
        let title = "Test Book"
        let author = "Test Author"
        let coverImageData = "test image".data(using: .utf8)
        let totalPage: Int32 = 200
        let currentPage: Int32 = 50
        let isbn = "978-0123456789"
        let shelfStatus = ShelfStatus.reading
        
        // When
        let book = coreDataService.createBook(
            title: title,
            author: author,
            coverImageData: coverImageData,
            totalPage: totalPage,
            currentPage: currentPage,
            isbn: isbn,
            shelfStatus: shelfStatus
        )
        
        // Then
        XCTAssertEqual(book.title, title)
        XCTAssertEqual(book.author, author)
        XCTAssertEqual(book.coverImageData, coverImageData)
        XCTAssertEqual(book.totalPage, totalPage)
        XCTAssertEqual(book.currentPage, currentPage)
        XCTAssertEqual(book.isbn, isbn)
        XCTAssertEqual(book.shelfStatus, shelfStatus.rawValue)
        XCTAssertNotNil(book.id)
        XCTAssertNotNil(book.dateAdded)
        XCTAssertNotNil(book.dateLastRead)
    }
    
    func testCreateBook_WithNilOptionalParameters_CreatesBookWithDefaults() {
        // Given
        let title = "Test Book"
        let author = "Test Author"
        let shelfStatus = ShelfStatus.toRead
        
        // When
        let book = coreDataService.createBook(
            title: title,
            author: author,
            coverImageData: nil,
            totalPage: nil,
            currentPage: nil,
            isbn: nil,
            shelfStatus: shelfStatus
        )
        
        // Then
        XCTAssertEqual(book.title, title)
        XCTAssertEqual(book.author, author)
        XCTAssertNil(book.coverImageData)
        XCTAssertEqual(book.totalPage, 1) // Assuming Core Data defaults to 1
        XCTAssertEqual(book.currentPage, 0)
        XCTAssertNil(book.isbn)
        XCTAssertEqual(book.shelfStatus, shelfStatus.rawValue)
    }
    
    // MARK: - Add Book Tests
    
    func testAddBook_SavesBookToContext() {
        // Given
        let book = coreDataService.createBook(
            title: "Test Book",
            author: "Test Author",
            coverImageData: nil,
            totalPage: nil,
            currentPage: nil,
            isbn: nil,
            shelfStatus: .toRead
        )
        
        // When
        coreDataService.addBook(book: book)
        
        // Then
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            let books = try testHelper.context.fetch(fetchRequest)
            XCTAssertEqual(books.count, 1)
            XCTAssertEqual(books.first?.title, "Test Book")
        } catch {
            XCTFail("Failed to fetch books: \(error)")
        }
    }
    
    // MARK: - Delete Book Tests
    
    func testDeleteBook_RemovesBookFromContext() {
        // Given
        let book = coreDataService.createBook(
            title: "Book to Delete",
            author: "Test Author",
            coverImageData: nil,
            totalPage: nil,
            currentPage: nil,
            isbn: nil,
            shelfStatus: .toRead
        )
        coreDataService.addBook(book: book)
        
        // Verify book was added
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            let books = try testHelper.context.fetch(fetchRequest)
            XCTAssertEqual(books.count, 1)
        } catch {
            XCTFail("Failed to verify book was added")
        }
        
        // When
        coreDataService.deleteBook(book: book)
        
        // Then
        do {
            let books = try testHelper.context.fetch(fetchRequest)
            XCTAssertEqual(books.count, 0)
        } catch {
            XCTFail("Failed to fetch books after deletion: \(error)")
        }
    }
    
    // MARK: - Handle New Book And Chapters Tests
    
    func testHandleNewBookAndChapters_WithChapters_CreatesBookAndChapters() {
        // Given
        let title = "Book with Chapters"
        let author = "Test Author"
        let chapter1 = ChapterPlaceholder(title: "Chapter 1", number: 1)
        let chapter2 = ChapterPlaceholder(title: "Chapter 2", number: 2)
        let chapters = [chapter1, chapter2]
        
        // When
        coreDataService.handleNewBookAndChapters(
            title: title,
            author: author,
            coverImageData: nil,
            totalPage: nil,
            currentPage: nil,
            isbn: nil,
            shelfStatus: .toRead,
            chapters: chapters
        )
        
        // Then - Check book was created
        let bookFetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            let books = try testHelper.context.fetch(bookFetchRequest)
            XCTAssertEqual(books.count, 1)
            
            let book = books.first!
            XCTAssertEqual(book.title, title)
            XCTAssertEqual(book.author, author)
            
            // Check chapters were created
            let chapterFetchRequest: NSFetchRequest<Chapter> = Chapter.fetchRequest()
            let chaptersInDb = try testHelper.context.fetch(chapterFetchRequest)
            XCTAssertEqual(chaptersInDb.count, 2)
            
            // Verify chapter details
            let sortedChapters = chaptersInDb.sorted { $0.number < $1.number }
            XCTAssertEqual(sortedChapters[0].title, "Chapter 1")
            XCTAssertEqual(sortedChapters[0].number, 1)
            XCTAssertEqual(sortedChapters[1].title, "Chapter 2")
            XCTAssertEqual(sortedChapters[1].number, 2)
            
            // Verify chapters are linked to book
            XCTAssertEqual(sortedChapters[0].book, book)
            XCTAssertEqual(sortedChapters[1].book, book)
            
        } catch {
            XCTFail("Failed to fetch data: \(error)")
        }
    }
    
    func testHandleNewBookAndChapters_WithEmptyChapters_CreatesOnlyBook() {
        // Given
        let title = "Book without Chapters"
        let author = "Test Author"
        let chapters: [ChapterPlaceholder] = []
        
        // When
        coreDataService.handleNewBookAndChapters(
            title: title,
            author: author,
            coverImageData: nil,
            totalPage: nil,
            currentPage: nil,
            isbn: nil,
            shelfStatus: .toRead,
            chapters: chapters
        )
        
        // Then
        let bookFetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        let chapterFetchRequest: NSFetchRequest<Chapter> = Chapter.fetchRequest()
        
        do {
            let books = try testHelper.context.fetch(bookFetchRequest)
            let chaptersInDb = try testHelper.context.fetch(chapterFetchRequest)
            
            XCTAssertEqual(books.count, 1)
            XCTAssertEqual(chaptersInDb.count, 0)
            XCTAssertEqual(books.first?.title, title)
        } catch {
            XCTFail("Failed to fetch data: \(error)")
        }
    }
    
    // MARK: - Add Chapter Tests
    
    func testAddChapter_WithValidChapters_SavesChaptersCorrectly() {
        // Given
        let book = coreDataService.createBook(
            title: "Test Book",
            author: "Test Author",
            coverImageData: nil,
            totalPage: nil,
            currentPage: nil,
            isbn: nil,
            shelfStatus: .toRead
        )
        coreDataService.addBook(book: book)
        
        var chapter1 = ChapterPlaceholder(title: "Chapter 1", number: 1)
        chapter1.startPage = 1
        chapter1.endPage = 20
        
        var chapter2 = ChapterPlaceholder(title: "Chapter 2", number: 2)
        chapter2.startPage = 21
        chapter2.endPage = 40
        
        let chapters = [chapter1, chapter2]
        
        // When
        coreDataService.addChapter(book: book, chapters: chapters)
        
        // Then
        let fetchRequest: NSFetchRequest<Chapter> = Chapter.fetchRequest()
        do {
            let savedChapters = try testHelper.context.fetch(fetchRequest)
            XCTAssertEqual(savedChapters.count, 2)
            
            let sortedChapters = savedChapters.sorted { $0.number < $1.number }
            XCTAssertEqual(sortedChapters[0].startPage, 1)
            XCTAssertEqual(sortedChapters[0].endPage, 20)
            XCTAssertEqual(sortedChapters[1].startPage, 21)
            XCTAssertEqual(sortedChapters[1].endPage, 40)
        } catch {
            XCTFail("Failed to fetch chapters: \(error)")
        }
    }
    
    func testAddChapter_WithEmptyChapters_DoesNotSaveAnything() {
        // Given
        let book = coreDataService.createBook(
            title: "Test Book",
            author: "Test Author",
            coverImageData: nil,
            totalPage: nil,
            currentPage: nil,
            isbn: nil,
            shelfStatus: .toRead
        )
        let chapters: [ChapterPlaceholder] = []
        
        // When
        coreDataService.addChapter(book: book, chapters: chapters)
        
        // Then
        let fetchRequest: NSFetchRequest<Chapter> = Chapter.fetchRequest()
        do {
            let savedChapters = try testHelper.context.fetch(fetchRequest)
            XCTAssertEqual(savedChapters.count, 0)
        } catch {
            XCTFail("Failed to fetch chapters: \(error)")
        }
    }
}
