//
//  DetailReviewsViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 30.06.24.
//

import SwiftUI

class DetailReviewsViewModel: ObservableObject {
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
        self.firestore.readFirestoreForAllUsers { reviews in
            DispatchQueue.main.async {
                self.reviewsCatalogue = reviews
            }
        } errorHandler: { error in
            self.firestoreError = error
        }
    }
}
