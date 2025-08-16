//
//  AddBookView.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import SwiftUI
import PhotosUI

struct AddBookView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: AddBookViewModel
    
    init() {
        let coreDataService = CoreDataService(context: PersistenceController.shared.container.viewContext)
        
        _viewModel = State(initialValue: AddBookViewModel(dataService: coreDataService))
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Book Details"){
                    TextField("Title*", text: $viewModel.title)
                    TextField("Author*", text: $viewModel.author)
                    TextField("Total Pages", value: $viewModel.totalPages, format: .number)
                    TextField("ISBN", text: $viewModel.bindingIsbn)
                    Picker("Current status", selection: $viewModel.shelfStatus) {
                        ForEach(ShelfStatus.allCases, id:\.self) { item in
                            Text(item.description)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    VStack(alignment: .center){
                        HStack{
                            Spacer()
                            PhotosPicker("Add Book Cover",selection: $viewModel.coverItem, matching: .images)
                                .padding(.horizontal, 50)
                            Spacer()
                        }
                        viewModel.coverImage?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                }
                
//                Section("Chapters"){
                List {
                    ForEach($viewModel.chapters) { $chapter in
                        HStack{
                            Text("\(chapter.number).")
                            TextField("Title", text: $chapter.name)
                            TextField("Start", value: $chapter.startPage, format: .number)
                                .frame(width: 50)
                            TextField("End", value: $chapter.endPage, format: .number)
                                .frame(width: 50)
                        }
                    }
                    .onDelete(perform: { atOffset in
                        viewModel.deleteChpater(atOffset)
                        viewModel.updateChapterNumbers()
                    })
                    .onMove(perform: {from, to in
                        viewModel.moveChapter(from: from, to: to)
                        viewModel.updateChapterNumbers()
                    })
                    Button("Add Chapter") {
                        viewModel.addChapter()
                    }
                }
            }
            // decide if keep
            .navigationTitle("Add New Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        viewModel.saveBook()
                        dismiss()
                    }
                    .disabled(viewModel.titleAndAuthorIsEmpty())
                }
            }
            .onChange(of: viewModel.coverItem) {
                viewModel.loadImage()
            }
        }
    }
}

#Preview {
    AddBookView()
}
