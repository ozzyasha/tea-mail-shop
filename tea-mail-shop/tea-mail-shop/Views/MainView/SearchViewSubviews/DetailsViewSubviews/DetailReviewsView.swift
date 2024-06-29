//
//  DetailReviewsView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 30.06.24.
//

import SwiftUI

struct DetailReviewsView: View {
    @StateObject
    var detailReviewsViewModel = DetailReviewsViewModel()
    @State
    private var isFirestoreErrorExists = false
    @State
    var tea: TeaCatalogueModel
    
    var body: some View {
        ScrollView {
            VStack {
                if !detailReviewsViewModel.reviewsCatalogue.isEmpty {
                    ForEach(detailReviewsViewModel.reviewsCatalogue.indices, id: \.self) { index in
                        let review = detailReviewsViewModel.reviewsCatalogue[index]
                        if review.teaId == tea.id {
                            ReviewsViewCell(review: review)
                        }
                    }
                } else {
                    Text("No reviews yet")
                        .foregroundStyle(.black)
                }
                Divider()
            }
        }
        .padding()
        .alert("Error: \(detailReviewsViewModel.firestoreError)", isPresented: $isFirestoreErrorExists) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    DetailReviewsView(tea: TeaCatalogueModel(id: 0, name: "Tea", price: "0 Br", img: "", teaDescription: "description", quantity: "0 шт."))
}
