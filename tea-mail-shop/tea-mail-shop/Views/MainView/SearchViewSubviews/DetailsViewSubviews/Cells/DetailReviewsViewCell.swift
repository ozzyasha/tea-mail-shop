//
//  DetailReviewsViewCell.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 30.06.24.
//

import SwiftUI

struct DetailReviewsViewCell: View {
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
                ZStack{
                    AsyncImage(
                        url: URL(string: review.avatar),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 70, maxHeight: 70)
                                .clipShape(Circle())
                        },
                        placeholder: {
                            ZStack {
                                Circle().frame(width: 70, height: 70)
                                    .foregroundStyle(Color.white)
                                    .overlay(Color.gray.opacity(0.2))
                                Image(systemName: "person.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(.gray)
                                    .offset(x: 0, y: 10)
                            }
                            .clipShape(Circle())
                        }
                    )
                }
                .padding(.trailing, 5)
                .padding(.bottom, 5)
                Text(review.username)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 18))
                    .bold()
                    .foregroundStyle(.accent)
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
    DetailReviewsViewCell(review: Review(id: "0", review: "Some review", reviewDate: "31 марта 2024 15:48", teaName: "Tea name", username: "Username", avatar: "", teaId: 0))
}
