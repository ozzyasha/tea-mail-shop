//
//  FirestoreService.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 6.06.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseCrashlytics
import FirebaseCrashlyticsSwift
import Combine

class FirestoreService: ObservableObject {
    
    init() {
        fetchUser()
    }
    
    private let ordersPath: String = "orders"
    
    private let store = Firestore.firestore()
    private var errorMessage = ""
    
    @Published
    var teamailUser: TeamailUser?
    
    func writeFirestore(username: String) {
        let usersRef = store.collection(UsersFirebaseFields.path.rawValue)
        
        usersRef.document("\(Auth.auth().currentUser?.uid ?? "undefined")").setData([
            UsersFirebaseFields.uid.rawValue: Auth.auth().currentUser?.uid ?? "can't receive an id",
            UsersFirebaseFields.username.rawValue: username,
            UsersFirebaseFields.email.rawValue: Auth.auth().currentUser?.email ?? "can't receive an email"
        ]) { err in
            if let err = err {
                self.errorMessage = "\(err)"
                return
            }
        }
    }
    
    func writeFirestore(orders: [TeaCatalogueModel]) {
        let usersRef = store.collection(UsersFirebaseFields.path.rawValue)
        let uid = "\(Auth.auth().currentUser?.uid ?? "undefined")"
        let counterRef = store.collection("orderID").document("orderCounter")
        
        counterRef.getDocument { (snapshot, error) in
            if let error = error {
                self.errorMessage = "Failed to get order id: \(error)"
                return
            }
            
            if let snapshot = snapshot, let counterValue = snapshot.get("value") as? Int {
                let ordersRef = usersRef.document(uid).collection(OrdersFirebaseFields.collection.rawValue).document("\(counterValue)")
                
                ordersRef.setData([
                    OrdersFirebaseFields.id.rawValue: ordersRef.documentID
                ])
                let teaItemsCollection = ordersRef.collection(TeasFirebaseFields.collection.rawValue)
                
                for tea in orders {
                    let teaItemsQuantity = orders.filter({$0.id == tea.id}).count
                    var teaQuantity = "0 шт."
                    
                    if tea.quantity.contains(" г.") {
                        teaQuantity = "\(teaItemsQuantity * (Int(tea.quantity.trimmingCharacters(in: CharacterSet(charactersIn: " г."))) ?? 0)) г."
                    } else if tea.quantity.contains(" шт.") {
                        teaQuantity = "\(teaItemsQuantity * (Int(tea.quantity.trimmingCharacters(in: CharacterSet(charactersIn: " шт."))) ?? 0)) шт."
                    }
                    
                    let teaPrice = "\((Int(tea.price.trimmingCharacters(in: CharacterSet(charactersIn: " Br"))) ?? 0) * teaItemsQuantity) Br"
                    
                    teaItemsCollection.document("\(tea.id)").setData([
                        TeasFirebaseFields.id.rawValue: tea.id,
                        TeasFirebaseFields.name.rawValue: tea.name,
                        TeasFirebaseFields.price.rawValue: teaPrice,
                        TeasFirebaseFields.quantity.rawValue: teaQuantity
                    ]) { err in
                        if let err = err {
                            self.errorMessage = "\(err)"
                            return
                        }
                    }
                }
                
                counterRef.updateData([
                    "value": counterValue + 1
                ]) { error in
                    if let error = error {
                        self.errorMessage = "Failed to update order value: \(error)"
                        return
                    }
                }
            }
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        store.collection(UsersFirebaseFields.path.rawValue).document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
            
            let uid = data[UsersFirebaseFields.uid.rawValue] as? String ?? ""
            let email = data[UsersFirebaseFields.email.rawValue] as? String ?? ""
            let username = data[UsersFirebaseFields.username.rawValue] as? String ?? ""
            
            self.teamailUser = TeamailUser(uid: uid, email: email, username: username)
        }
    }
    
    func readFirestore(completion: @escaping (TeamailUser?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        store.collection(UsersFirebaseFields.path.rawValue).document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                return
            }
            
            guard let data = snapshot?.data() else {
                completion(nil)
                self.errorMessage = "No data found"
                return
            }
            
            let uid = data[UsersFirebaseFields.uid.rawValue] as? String ?? ""
            let email = data[UsersFirebaseFields.email.rawValue] as? String ?? ""
            let username = data[UsersFirebaseFields.username.rawValue] as? String ?? ""
            
            completion(TeamailUser(uid: uid, email: email, username: username))
        }
    }
    
    func readFirestore(completion: @escaping ([Order]) -> (), errorHandler: @escaping (String) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }
        let ordersRef = store.collection(UsersFirebaseFields.path.rawValue)
            .document(uid)
            .collection(OrdersFirebaseFields.collection.rawValue)
        ordersRef.getDocuments { snapshot, error in
            if let error = error {
                errorHandler("Failed to fetch orders: \(error)")
                completion([])
                return
            }
            
            let orderedTeas: [OrderedTea] = []
            var orders: [Order] = []
            
            for orderDocument in snapshot!.documents {
                guard let orderId = orderDocument.get(OrdersFirebaseFields.id.rawValue) as? String else {
                    errorHandler("Warning: Missing data for order \(orderDocument.documentID)")
                    continue
                }
                var order = Order(id: orderId, orderedTeasArray: orderedTeas)
                
                let orderedTeaItemsRef = orderDocument.reference.collection(TeasFirebaseFields.collection.rawValue)
                orderedTeaItemsRef.getDocuments { teaItemsSnapshot, teaItemsError in
                    if let teaItemsError = teaItemsError {
                        errorHandler("Error fetching ordered tea items: \(teaItemsError)")
                        completion([])
                        return
                    }
                    
                    for teaItemDocument in teaItemsSnapshot!.documents {
                        guard let teaId = teaItemDocument.get(TeasFirebaseFields.id.rawValue) as? Int,
                              let teaName = teaItemDocument.get(TeasFirebaseFields.name.rawValue) as? String,
                              let teaPrice = teaItemDocument.get(TeasFirebaseFields.price.rawValue) as? String,
                              let teaQuantity = teaItemDocument.get(TeasFirebaseFields.quantity.rawValue) as? String else {
                            errorHandler("Warning: Missing data for ordered tea item \(teaItemDocument.documentID)")
                            continue
                        }
                        let orderedTea = OrderedTea(id: teaId, name: teaName, price: teaPrice, quantity: teaQuantity)
                        order.orderedTeasArray.append(orderedTea)
                    }
                    
                    orders.append(order)
                    
                    completion(orders)
                }
            }
        }
    }
}
