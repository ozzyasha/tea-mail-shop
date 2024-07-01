//
//  ReviewsViewModelTests.swift
//  tea-mail-shopTests
//
//  Created by Наталья Мазур on 1.07.24.
//

import XCTest
@testable import tea_mail_shop

class ReviewsViewModelTests: XCTestCase {
    
    class MockFirestoreService: FirestoreService {
        var reviews: [Review] = []
        
        override func readFirestore(completion: @escaping ([Review]) -> (), errorHandler: @escaping (String) -> ()) {
            completion(reviews)
        }
    }
    
    var viewModel: ReviewsViewModel!
    var mockFirestore: MockFirestoreService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockFirestore = MockFirestoreService()
        viewModel = ReviewsViewModel()
        viewModel.firestore = mockFirestore
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockFirestore = nil
        try super.tearDownWithError()
    }
    
    func testReadAllReviewsSuccess() {
        let mockReviews = [
            Review(id: "0", review: "Some review", reviewDate: "31 марта 2024 15:48", teaName: "Tea name", username: "Username", avatar: "", teaId: 0),
            Review(id: "1", review: "Another review", reviewDate: "31 марта 2024 15:49", teaName: "Tea name", username: "Second username", avatar: "", teaId: 0)
        ]
        mockFirestore.reviews = mockReviews
        
        viewModel.readAllReviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.reviewsCatalogue.count, 2)
            XCTAssertEqual(self.viewModel.firestoreError, "")
        }
    }
    
    func testReadAllReviewsFailure() {
        let mockError = "Firestore error"
        mockFirestore.reviews = []
        
        viewModel.readAllReviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.reviewsCatalogue.count, 0)
            XCTAssertEqual(self.viewModel.firestoreError, mockError)
        }
    }
}
