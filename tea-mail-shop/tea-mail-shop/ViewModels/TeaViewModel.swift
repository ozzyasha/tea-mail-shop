//
//  TeaViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation
import SwiftUI

class TeaViewModel: ObservableObject {
    
    @Published
    var teaCatalogueModel = [TeaCatalogueModel]()
    @Published
    var errorMessage = ""
    
    init() {
        teaCatalogueModel = RealmService.shared.readAllTeaCatalogueFromDatabase()
        
        guard !teaCatalogueModel.isEmpty else {
            APIService.shared.fetchData(endpoint: .teaCatalogue, responseType: TeaCatalogueResponse.self) { response in
                DispatchQueue.main.async {
                    for tea in response.teaCatalogue {
                        RealmService.shared.saveOrUpdateTea(teaModel: tea)
                        self.teaCatalogueModel.append(tea)
                    }
                }
                
            } errorHandler: { error in
                self.errorMessage = "\(error)"
            }
            return
        }
        
    }
    
    
}
