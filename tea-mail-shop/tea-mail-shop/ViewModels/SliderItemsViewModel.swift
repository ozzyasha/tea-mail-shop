//
//  SliderItemsViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 20.06.24.
//

import Foundation
import SwiftUI

class SliderItemsViewModel: ObservableObject {
    
    @Published
    var sliderItemsModel = [SliderItemsModel]()
    
    init() {
        sliderItemsModel = RealmService.shared.readAllSliderItemsFromDatabase()
        
        guard !sliderItemsModel.isEmpty else {
            APIService.shared.fetchData(endpoint: .sliderItems, responseType: SliderItemsResponse.self) { response in
                DispatchQueue.main.async {
                    for item in response.sliderItems {
                        RealmService.shared.saveOrUpdateSliderItem(sliderItem: item)
                        self.sliderItemsModel.append(item)
                    }
                }
                
            } errorHandler: { error in
                print(error) //  алерт
            }
            return
        }
        
    }
    
    
}
