//
//  CoreDataService+Book.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 10/08/2025.
//

import Foundation

extension CoreDataService {
    func addBook(title: String, author: String, totalPages: Int32) {
        let newBook = Book(context: context)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.totalPage = totalPages
        
        do {
            try context.save()
        } catch {
            print("Failed to save book: \(error)")
        }
    }
}
