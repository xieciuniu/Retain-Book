//
//  BookshelfView.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import SwiftUI

struct BookshelfView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateLastRead, order: .reverse)], animation: .default)
    private var books: FetchedResults<Book>
    
    @State var viewModel: BookshelfViewModel
     init() {
         let coreDataService = CoreDataService(context: PersistenceController.shared.container.viewContext)
         
         _viewModel = State(initialValue: BookshelfViewModel(dataService: coreDataService))
     }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books){ book in
                    HStack(spacing: 10){
//                        Spacer()
//                            .frame(width: 60, height: 60)
//                            .background(.blue)
                        if book.coverImageData != nil {
                            Image(uiImage: viewModel.convertDataToImage(book.coverImageData!)!)
                                .resizable()
                                .frame(width: 60, height: 80)
                        } else {
                            Text("don't have cover image")
                                .frame(width:60, height: 80)
                        }
                        VStack(alignment: .leading){
                            Text(book.title ?? "error")
                                .font(.headline)
                            Text(book.author ?? "error")
                            Text(book.dateLastRead?.description ?? "error")
                        }
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteBook(books: Array(books), offsets: indexSet)
                }
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
