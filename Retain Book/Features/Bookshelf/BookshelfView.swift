//
//  BookshelfView.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import SwiftUI

struct BookshelfView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateLastRead, order: .reverse)], animation: .bouncy)
    private var books: FetchedResults<Book>
    
    @State var viewModel: BookshelfViewModel
     init() {
         let coreDataService = CoreDataService(context: PersistenceController.shared.container.viewContext)
         
         _viewModel = State(initialValue: BookshelfViewModel(dataService: coreDataService))
     }
    
    var filteredBooks: [Book] {
        if viewModel.searchText.isEmpty {
            return books.map { $0 }
        } else {
            return books.filter { book in
                (book.title?.localizedCaseInsensitiveContains(viewModel.searchText) ?? false ) ||  (book.author?.localizedCaseInsensitiveContains(viewModel.searchText) ?? false)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBooks){ book in
                    HStack(spacing: 10){
                        if book.coverImageData != nil {
                            Image(uiImage: viewModel.convertDataToImage(book.coverImageData!)!)
                                .resizable()
                                .frame(width: 60, height: 90)
                        } else {
                            Spacer()
                                .frame(width: 60, height: 90)
                                .background(.gray)
                        }
                        VStack(alignment: .leading){
                            Text(book.title ?? "error")
                                .font(.headline)
                            Text(book.author ?? "error")
                        }
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteBook(books: Array(books), offsets: indexSet)
                }
            }
            .navigationTitle("Bookshelf")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
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
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.searchIsActive)
    }
}

#Preview {
    BookshelfView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
