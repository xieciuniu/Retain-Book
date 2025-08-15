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
                        TextField("Title", text: $viewModel.title)
                        TextField("Author", text: $viewModel.author)
                        TextField("Total Pages", value: $viewModel.totalPages, format: .number)
                }
                Section{
                    VStack{
                        PhotosPicker("Add Book Cover",selection: $viewModel.coverItem, matching: .images)
                        viewModel.coverImage?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                }
//                Button("Add") {}
            }
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
