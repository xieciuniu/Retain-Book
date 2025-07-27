//
//  AddBookViewModel.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation
import Observation

@Observable class AddBookViewModel {
    
    var title: String = ""
    var author: String = ""
    var totalPages: String = ""
    
    private var dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func saveBook () {
       let page = convertStringToInt32(totalPages)
        
        dataService.addBook(title: title, author: author, totalPages: page)
    }
    
    func convertStringToInt32(_ string: String) -> Int32 {
        return Int32(string) ?? 0
    }
}
