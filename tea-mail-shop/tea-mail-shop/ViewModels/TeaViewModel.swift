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
    
    init() {
        teaCatalogueModel = RealmService.shared.readAllTeaCatalogueFromDatabase()
        
        guard !teaCatalogueModel.isEmpty else {
            APIService.shared.fetchData(completionHandler: { teaCatalogue in
                DispatchQueue.main.async {
                    for tea in teaCatalogue {
                        RealmService.shared.saveOrUpdateTea(teaModel: tea)
                        self.teaCatalogueModel.append(tea)
                    }
                }
                
            }, errorHandler: { error in
                print(error) //  алерт
            })
            return
        }
        
    }
    
    
}
