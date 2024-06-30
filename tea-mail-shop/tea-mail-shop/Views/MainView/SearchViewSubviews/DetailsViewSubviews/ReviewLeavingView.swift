//
//  ReviewLeavingView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 29.06.24.
//

import SwiftUI

struct ReviewLeavingView: View {
    @ObservedObject
    var reviewsViewModel: ReviewsViewModel
    @Binding
    var tea: TeaCatalogueModel
    @ObservedObject
    var firestore = FirestoreService()
    @State
    var submitAlertIsPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Leave a review")
                .foregroundStyle(.accent)
                .font(.title)
                .bold()
                .padding(.vertical)
            TextEditor(text: $reviewsViewModel.reviewText)
                .foregroundStyle(.black)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .contentMargins(5)
                .padding(.vertical)
            HStack {
                Spacer()
                Button {
                    firestore.writeFirestore(review: reviewsViewModel.reviewText, for: tea)
                    submitAlertIsPresented = true
                } label: {
                    Text("Submit")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(.accent)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .alert("Thank you for your review!", isPresented: $submitAlertIsPresented) {
                    Button("OK", role: .cancel) {
                        reviewsViewModel.isReviewsViewPresented = false
                    }
                }
            }
        }
        .padding()
        .background(.additional)
    }
}

#Preview {
    ReviewLeavingView(reviewsViewModel: ReviewsViewModel(), tea: .constant(TeaCatalogueModel(id: 0, name: "name", price: "price", img: "img", teaDescription: "description", quantity: "quantity")))
}
