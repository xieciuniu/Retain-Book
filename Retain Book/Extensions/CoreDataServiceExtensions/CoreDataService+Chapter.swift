//
//  CoreDataService+Chapter.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 17/08/2025.
//

import Foundation

extension CoreDataService {
    
    func addChapter(book: Book, chapters: [ChapterPlaceholder]) {
        guard chapters.isEmpty == false else { return }
        
        let _: [Chapter] = chapters.map {
            let chapter = Chapter(context: context)
            chapter.id = $0.id
            chapter.title = $0.title
            chapter.number = $0.number
            chapter.startPage = $0.startPage ?? 0
            chapter.endPage = $0.endPage ?? 0
            chapter.book = book
            return chapter
        }
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
}
