//
//  CoreDataService+Book.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 10/08/2025.
//

import Foundation

extension CoreDataService {
    func addBook(book: Book) {
        
        context.insert(book)
        
        do {
            try context.save()
        } catch {
            print("Failed to save book: \(error)")
        }
    }
    
    func createBook(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus) -> Book {
        let newBook = Book(context: context)
        
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.coverImageData = coverImageData
        if let totalPage { newBook.totalPage = totalPage }
        if let currentPage { newBook.currentPage = currentPage}
        newBook.dateAdded = Date()
        newBook.dateLastRead = Date()
        if let isbn { newBook.isbn = isbn }
        newBook.shelfStatus = shelfStatus.rawValue
        
        return newBook
    }
    
    func deleteBook(book: Book) {
        context.delete(book)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func editBook(id: Int32, title: String?, author: String?, totalPages: Int32?) {
        
    }
        
    func handleNewBookAndChapters(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus, chapters: [ChapterPlaceholder]) {
        let book = createBook(title: title, author: author, coverImageData: coverImageData, totalPage: totalPage, currentPage: currentPage, isbn: isbn, shelfStatus: shelfStatus)
        
        addBook(book: book)
        addChapter(book: book, chapters: chapters)
    }
}
