//
//  BookshelfViewModel.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation
import Observation
import UIKit

@Observable class BookshelfViewModel {
    
    var isShowingAddBookView = false
    
    private var dataService: DataService
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func deleteBook(books: [Book], offsets: IndexSet) {
        for index in offsets {
            let bookToDelete = books[index]
            dataService.deleteBook(book: bookToDelete)
        }
    }
    
    func convertDataToImage(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
