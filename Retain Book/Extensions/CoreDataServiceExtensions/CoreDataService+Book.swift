//
//  CoreDataService+Book.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 10/08/2025.
//

import Foundation

extension CoreDataService {
    func addBook(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus) -> Book {
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
        
        do {
            try context.save()
        } catch {
            print("Failed to save book: \(error)")
        }
        
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
    
    func handleNewBookWithChapters(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus, chapters: [ChapterPlaceholder]) {
        let book = addBook(title: title, author: author, coverImageData: coverImageData, totalPage: totalPage, currentPage: currentPage, isbn: isbn, shelfStatus: shelfStatus)
        addChapter(book: book, chapters: chapters)
    }
}
