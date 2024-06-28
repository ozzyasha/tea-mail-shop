//
//  OrdersViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 27.06.24.
//

import Foundation
import SwiftUI

class OrdersViewModel: ObservableObject {
    @Published
    var ordersCatalogue = [Order]()
    @ObservedObject
    var firestore = FirestoreService()
    @Published
    var firestoreError = ""
    
    init() {
        readAllOrders()
    }
    
    func readAllOrders() {
        self.firestore.readFirestore { orders in
            DispatchQueue.main.async {
                self.ordersCatalogue = orders
            }
            
        } errorHandler: { error in
            self.firestoreError = error
        }
    }
}
