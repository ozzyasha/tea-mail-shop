//
//  ReviewsViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 29.06.24.
//

import SwiftUI

class ReviewsViewModel: ObservableObject {
    @Published
    var isReviewsViewPresented = false
    @Published
    var reviewText = ""
    @Published
    var reviewsCatalogue = [Review]()
    @ObservedObject
    var firestore = FirestoreService()
    @Published
    var firestoreError = ""
    
    init() {
        DispatchQueue.main.async {
            self.readAllReviews()
        }
    }
    
    func readAllReviews() {
        self.firestore.readFirestore { reviews in
            DispatchQueue.main.async {
                self.reviewsCatalogue = reviews
            }
        } errorHandler: { error in
            self.firestoreError = error
        }
    }
}
