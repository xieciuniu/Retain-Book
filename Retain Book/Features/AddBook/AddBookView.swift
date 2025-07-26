//
//  AddBookView.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import SwiftUI

struct AddBookView: View {
    
    @Bindable var viewModel = AddBookViewModel()
    
    var body: some View {
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
    }
}

#Preview {
    AddBookView()
}
