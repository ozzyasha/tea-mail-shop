//
//  ReviewsViewCell.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 30.06.24.
//

import SwiftUI

struct ReviewsViewCell: View {
    @State
    var review: Review
    @State
    var isTeaDetailsOpened = false
    @ObservedObject
    var reviewsViewModel = ReviewsViewModel()
    @ObservedObject
    var teaVM = TeaViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(review.reviewDate)
                    .foregroundStyle(.black)
                    .font(.system(size: 15))
                    .italic()
                    .padding(.bottom)
            }
            HStack {
                Button {
                    isTeaDetailsOpened = true
                } label: {
                    Text(review.teaName)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 18))
                        .bold()
                        .foregroundStyle(.accent)
                }
                .fullScreenCover(isPresented: $isTeaDetailsOpened) {
                    if let tea = teaVM.teaCatalogueModel.first(where: {$0.id == review.teaId}) {
                        DetailsView(tea: tea, reviewsViewModel: reviewsViewModel)
                    }
                }
                Spacer()
            }
            Divider()
            HStack {
                Text("\(review.review)")
                    .foregroundStyle(.black)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }
}

#Preview {
    ReviewsViewCell(review: Review(id: "0", review: "Some review", reviewDate: "31 марта 2024 15:48", teaName: "Tea name", username: "Username", avatar: "", teaId: 0))
}
