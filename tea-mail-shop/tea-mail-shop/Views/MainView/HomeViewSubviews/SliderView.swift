//
//  SliderView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 20.06.24.
//

import SwiftUI

struct SliderView: View {
    @ObservedObject
    var sliderItemsViewModel: SliderItemsViewModel
    @State
    private var currentIndex = 0
    @State
    private var isDragging = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                if sliderItemsViewModel.sliderItemsModel.isEmpty {
                    ProgressView()
                } else {
                    SliderItemImageView(imageURL: sliderItemsViewModel.sliderItemsModel[currentIndex].img, linkURL: sliderItemsViewModel.sliderItemsModel[currentIndex].url, currentIndex: $currentIndex)
                        .transition(.opacity)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.translation.width < 0 {
                                        isDragging = true
                                    }
                                    if value.translation.width > 0 {
                                        isDragging = false
                                    }
                                }
                                .onEnded { value in
                                    if isDragging {
                                        currentIndex = (currentIndex + 1) % sliderItemsViewModel.sliderItemsModel.count
                                    } else {
                                        currentIndex = (currentIndex - 1 + sliderItemsViewModel.sliderItemsModel.count) % sliderItemsViewModel.sliderItemsModel.count
                                    }
                                }
                        )
                    
                }
            }
            
            HStack {
                ForEach(0..<sliderItemsViewModel.sliderItemsModel.count, id: \.self) { index in
                    Circle()
                        .fill(self.currentIndex == index ? Color.accentColor : Color.secondAdditional)
                        .frame(width: 10, height: 10)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1)) {
                                self.currentIndex = index
                            }
                        }
                    
                }
            }
            .padding()
            
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                withAnimation(.easeInOut(duration: 1)) {
                    if self.currentIndex + 1 == self.sliderItemsViewModel.sliderItemsModel.count {
                        self.currentIndex = 0
                    } else {
                        self.currentIndex += 1
                    }
                }
            }
            
        }
    }
    
}

#Preview {
    SliderView(sliderItemsViewModel: SliderItemsViewModel())
}
