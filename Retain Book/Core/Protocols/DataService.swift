//
//  DataService.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation

protocol DataService {
    func addBook(title: String, author: String, totalPages: Int32)
}
