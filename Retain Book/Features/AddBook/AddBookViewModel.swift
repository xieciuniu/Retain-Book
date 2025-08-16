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
    var bindingIsbn: String = ""
    var isbn: String? {
        if bindingIsbn.isEmpty {
            return nil
        } else {
            return bindingIsbn
        }
    }
    var shelfStatus: ShelfStatus = .toRead
    
    var chapters: [OneChapter] = []
    
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
    
    func titleAndAuthorIsEmpty() -> Bool {
        if title.isEmpty || author.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func addChapter() {
        let chapter: OneChapter = OneChapter(name: "", number: Int32(chapters.count + 1))
        chapters.append(chapter)
    }
    
    func deleteChpater(_ atOffset: IndexSet) {
        chapters.remove(atOffsets: atOffset)
    }
    
    func moveChapter(from source: IndexSet, to destination: Int) {
        chapters.move(fromOffsets: source, toOffset: destination)
    }
    
    func updateChapterNumbers() {
        for i in 1..<chapters.count + 1 {
            chapters[i - 1].number = Int32(i)
        }
    }
    
}

struct OneChapter: Identifiable {
    var id = UUID()
    var name: String
    var number: Int32
    var startPage: Int32?
    var endPage: Int32?
}
