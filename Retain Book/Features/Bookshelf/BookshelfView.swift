//
//  BookshelfView.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import SwiftUI

struct BookshelfView: View {
    
    @Bindable var viewModel = BookshelfViewModel()
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateLastRead)])
    private var books: FetchedResults<Book>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books){ book in
                    VStack {
                        Text(book.title ?? "error")
                            .font(.headline)
                        Text(book.author ?? "error")
                    }
                }
                .onDelete(perform: viewModel.deleteBook)
            }
            .navigationTitle("Bookshelf")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        viewModel.isShowingAddBookView = true
                    } label : {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddBookView) {
                AddBookView()
            }
        }
    }
}

#Preview {
    BookshelfView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
