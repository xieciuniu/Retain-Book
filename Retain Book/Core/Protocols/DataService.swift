//
//  DataService.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation

protocol DataService {
    // MARK: Books Entitie
    func addBook(book: Book)
    func createBook(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus) -> Book
    func editBook(id: Int32, title: String?, author: String?, totalPages: Int32?)
    func deleteBook(book: Book)
    func handleNewBookAndChapters(title: String, author: String, coverImageData: Data?, totalPage: Int32?, currentPage: Int32?, isbn: String?, shelfStatus: ShelfStatus, chapters: [ChapterPlaceholder])
    
    // MARK: Chapter Entities
    func addChapter(book: Book ,chapters: [ChapterPlaceholder])
    
}
