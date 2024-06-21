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
    private var isDragging = false
    @State
    private var draggingValue: CGFloat = 0
    @State
    private var timer: Timer?
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                if sliderItemsViewModel.sliderItemsModel.isEmpty {
                    ProgressView()
                } else {
                    ZStack {
                        SliderItemImageView(imageURL: sliderItemsViewModel.sliderItemsModel[sliderItemsViewModel.currentIndex].img, linkURL: sliderItemsViewModel.sliderItemsModel[sliderItemsViewModel.currentIndex].url, draggingValue: $draggingValue)
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
                                        draggingValue = value.translation.width
                                    }
                                    .onEnded { value in
                                        if isDragging {
                                            sliderItemsViewModel.setupNextIndexAsCurrent()
                                        } else {
                                            sliderItemsViewModel.setupPreviousIndexAsCurrent()
                                        }
                                        draggingValue = 0
                                        timer?.invalidate()
                                        setupTimer()
                                    }
                            )
                    }
                    
                }
            }
            
            HStack {
                ForEach(0..<sliderItemsViewModel.sliderItemsModel.count, id: \.self) { index in
                    Circle()
                        .fill(sliderItemsViewModel.currentIndex == index ? Color.accentColor : Color.secondAdditional)
                        .frame(width: 10, height: 10)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1)) {
                                sliderItemsViewModel.currentIndex = index
                            }
                            timer?.invalidate()
                            setupTimer()
                        }
                    
                }
            }
            .padding()
            
        }
        .onAppear {
            setupTimer()
        }
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 1)) {
                if sliderItemsViewModel.currentIndex + 1 == self.sliderItemsViewModel.sliderItemsModel.count {
                    sliderItemsViewModel.currentIndex = 0
                } else {
                    sliderItemsViewModel.currentIndex += 1
                }
            }
        }
    }
    
}

#Preview {
    SliderView(sliderItemsViewModel: SliderItemsViewModel())
}
