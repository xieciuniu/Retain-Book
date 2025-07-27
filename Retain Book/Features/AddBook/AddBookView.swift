//
//  AddBookView.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import SwiftUI

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
                    HStack(alignment: .center) {
                        TextField("Title", text: $viewModel.title)
                    }
                    HStack {
                        TextField("Author", text: $viewModel.author)
                    }
                    HStack {
                        TextField("Total Pages", text: $viewModel.totalPages)
                            .keyboardType(.numberPad)
                    }
                }
                Button("Add") {}
            }
            .navigationTitle("Add New Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveBook()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddBookView()
}
