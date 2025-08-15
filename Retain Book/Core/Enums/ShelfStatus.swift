//
//  ShelfStatus.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 15/08/2025.
//

import Foundation

enum ShelfStatus: Int16, CaseIterable {
    case toRead = 0
    case reading = 1
    case read = 2
    case abandoned = 3
}
