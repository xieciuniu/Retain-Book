//
//  AddBookView.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 26/07/2025.
//

import SwiftUI

struct AddBookView: View {
    var body: some View {
        Form {
            Section("Must add"){
                HStack(alignment: .center) {
                    TextField("Title", text: .constant(""))
                }
                HStack {
                    TextField("Author", text: .constant(""))
                }
                HStack {
                    TextField("Total Pages", text: .constant(""))
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
