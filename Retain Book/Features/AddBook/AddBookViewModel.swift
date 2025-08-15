//
//  AddBookViewModel.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import Foundation
import Observation
import SwiftUI
import PhotosUI

@Observable class AddBookViewModel {
    
    var title: String = ""
    var author: String = ""
    var totalPages: Int32?
    var currentPage: Int32?
    var coverImageData: Data?
    var isbn: String?
    var shelfStatus: ShelfStatus = .toRead
    
    var coverItem: PhotosPickerItem?
    var coverImage: Image?
    
    private var dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func saveBook () {
        Task{
            let coverImageData: Data? = await convertImageToData()
    
            dataService.addBook(title: title, author: author, coverImageData: coverImageData, totalPage: totalPages, currentPage: 0, isbn: isbn, shelfStatus: shelfStatus)
        }
    }
    
    func loadImage() {
        Task{
            if let loaded = try? await coverItem?.loadTransferable(type: Image.self) {
                coverImage = loaded
            } else {
                print("Failed to load Image")
            }
        }
    }
    
    func convertImageToData() async -> Data? {
        do {
            let imageData = try await coverItem?.loadTransferable(type: Data.self)
            return imageData
        } catch {
            print("Error loading image data: \(error)")
            return nil
        }
    }
    
}
