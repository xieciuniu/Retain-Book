//
//  BookshelfViewModelTests.swift
//  Retain BookTests
//
//  Created by Hubert Wojtowicz on 31/08/2025.
//

import XCTest
import UIKit
@testable import Retain_Book

class BookshelfViewModelTests: XCTestCase {
    
    var viewModel: BookshelfViewModel!
    var mockDataService: MockDataService!
    var testHelper: CoreDataTestHelper!
    
    override func setUp() {
        super.setUp()
        testHelper = CoreDataTestHelper()
        mockDataService = MockDataService(context: testHelper.context)
        viewModel = BookshelfViewModel(dataService: mockDataService)
    }
    
    override func tearDown() {
        testHelper.reset()
        viewModel = nil
        mockDataService = nil
        testHelper = nil
        super.tearDown()
    }
    
    // MARK: - Initial State Tests
    
    func testInitialState_HasExpectedDefaults() {
        // Then
        XCTAssertFalse(viewModel.isShowingAddBookView)
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertFalse(viewModel.searchIsActive)
    }
    
    // MARK: - Delete Book Tests
    
    func testDeleteBook_SingleBook_CallsDataServiceOnce() {
        // Given
        let mockBook = createMockBook(title: "Test Book")
        let books = [mockBook]
        let indexSet = IndexSet(integer: 0)
        
        // When
        viewModel.deleteBook(books: books, offsets: indexSet)
        
        // Then
        XCTAssertEqual(mockDataService.deleteBookCallCount, 1)
        XCTAssertEqual(mockDataService.lastDeletedBook?.title, "Test Book")
    }
    
    func testDeleteBook_MultipleBooks_CallsDataServiceForEachBook() {
        // Given
        let book1 = createMockBook(title: "Book 1")
        let book2 = createMockBook(title: "Book 2")
        let book3 = createMockBook(title: "Book 3")
        let books = [book1, book2, book3]
        
        var indexSet = IndexSet()
        indexSet.insert(0) // Delete first book
        indexSet.insert(2) // Delete third book
        
        // When
        viewModel.deleteBook(books: books, offsets: indexSet)
        
        // Then
        XCTAssertEqual(mockDataService.deleteBookCallCount, 2)
        // Note: The last deleted book will be the last one processed
    }
    
    func testDeleteBook_EmptyIndexSet_DoesNotCallDataService() {
        // Given
        let books = [createMockBook(title: "Test Book")]
        let emptyIndexSet = IndexSet()
        
        // When
        viewModel.deleteBook(books: books, offsets: emptyIndexSet)
        
        // Then
        XCTAssertEqual(mockDataService.deleteBookCallCount, 0)
    }
    
    // MARK: - Image Conversion Tests
    
    func testConvertDataToImage_ValidImageData_ReturnsUIImage() {
        // Given
        let imageData = createTestImageData()
        
        // When
        let result = viewModel.convertDataToImage(imageData)
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertTrue(result is UIImage)
    }
    
    func testConvertDataToImage_InvalidData_ReturnsNil() {
        // Given
        let invalidData = "This is not image data".data(using: .utf8)!
        
        // When
        let result = viewModel.convertDataToImage(invalidData)
        
        // Then
        XCTAssertNil(result)
    }
    
    func testConvertDataToImage_EmptyData_ReturnsNil() {
        // Given
        let emptyData = Data()
        
        // When
        let result = viewModel.convertDataToImage(emptyData)
        
        // Then
        XCTAssertNil(result)
    }
    
    // MARK: - State Management Tests
    
    func testSearchTextUpdates_MaintainsValue() {
        // Given
        let searchQuery = "Swift Programming"
        
        // When
        viewModel.searchText = searchQuery
        
        // Then
        XCTAssertEqual(viewModel.searchText, searchQuery)
    }
    
    func testIsShowingAddBookView_TogglesCorrectly() {
        // Given
        let initialValue = viewModel.isShowingAddBookView
        
        // When
        viewModel.isShowingAddBookView.toggle()
        
        // Then
        XCTAssertNotEqual(viewModel.isShowingAddBookView, initialValue)
        
        // When
        viewModel.isShowingAddBookView.toggle()
        
        // Then
        XCTAssertEqual(viewModel.isShowingAddBookView, initialValue)
    }
    
    // MARK: - Helper Methods
    
    private func createMockBook(title: String) -> Book {
        return mockDataService.createBook(
            title: title,
            author: "Test Author",
            coverImageData: nil,
            totalPage: nil,
            currentPage: nil,
            isbn: nil,
            shelfStatus: .toRead
        )
    }
    
    private func createTestImageData() -> Data {
        // Create a simple 1x1 pixel image for testing
        let image = UIImage(systemName: "book") ?? UIImage()
        return image.pngData() ?? Data()
    }
}
