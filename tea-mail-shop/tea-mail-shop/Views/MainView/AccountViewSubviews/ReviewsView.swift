//
//  ReviewsView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 29.06.24.
//

import SwiftUI

struct ReviewsView: View {
    @StateObject
    var reviewsViewModel = ReviewsViewModel()
    @State
    private var isFirestoreErrorExists = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject
    private var tabViewModel: TabViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.additional.ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack {
                        if !reviewsViewModel.reviewsCatalogue.isEmpty {
                            ForEach(reviewsViewModel.reviewsCatalogue.indices, id: \.self) { index in
                                let review = reviewsViewModel.reviewsCatalogue[index]
                                ReviewsViewCell(review: review)
                            }
                        } else {
                            Text("You don't have reviews yet")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding()
                .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.accent)
            }
        }
        .alert("Error: \(reviewsViewModel.firestoreError)", isPresented: $isFirestoreErrorExists) {
            Button("OK", role: .cancel) { }
        }
        .onChange(of: tabViewModel.selectedTab) {
            if tabViewModel.selectedTab == .account {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    ReviewsView()
        .environmentObject(TabViewModel())
}
