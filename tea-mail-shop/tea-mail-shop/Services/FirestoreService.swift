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
                    OrdersFirebaseFields.id.rawValue: Int(ordersRef.documentID) ?? "0"
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
    
    func writeFirestore(review: String, for tea: TeaCatalogueModel) {
        let usersRef = store.collection(UsersFirebaseFields.path.rawValue)
        let uid = "\(Auth.auth().currentUser?.uid ?? "undefined")"
        let reviewRef = usersRef.document(uid).collection(ReviewsFirebaseFields.reviewsCollection.rawValue).document()
        
        let timestamp = Date().timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
        
        reviewRef.setData([
            ReviewsFirebaseFields.reviewId.rawValue: reviewRef.documentID,
            ReviewsFirebaseFields.teaId.rawValue: tea.id,
            ReviewsFirebaseFields.teaName.rawValue: tea.name,
            ReviewsFirebaseFields.reviewDate.rawValue: dateString,
            ReviewsFirebaseFields.review.rawValue: review
        ]) { err in
            if let err = err {
                self.errorMessage = "\(err)"
                return
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
        
        Task {
            do {
                let snapshot = try await ordersRef.getDocuments()
                
                var orders: [Order] = []
                
                for orderDocument in snapshot.documents {
                    guard let orderId = orderDocument.get(OrdersFirebaseFields.id.rawValue) as? Int else {
                        errorHandler("Warning: Missing data for order \(orderDocument.documentID)")
                        continue
                    }
                    
                    let orderedTeaItemsRef = orderDocument.reference.collection(TeasFirebaseFields.collection.rawValue)
                    let orderedTeas = try await orderedTeaItemsRef.getDocuments()
                    let teaItems = orderedTeas.documents.compactMap { document -> OrderedTea? in
                        guard let teaId = document.get(TeasFirebaseFields.id.rawValue) as? Int,
                              let teaName = document.get(TeasFirebaseFields.name.rawValue) as? String,
                              let teaPrice = document.get(TeasFirebaseFields.price.rawValue) as? String,
                              let teaQuantity = document.get(TeasFirebaseFields.quantity.rawValue) as? String else {
                            errorHandler("Warning: Missing data for ordered tea item \(document.documentID)")
                            return nil
                        }
                        return OrderedTea(id: teaId, name: teaName, price: teaPrice, quantity: teaQuantity)
                    }
                    
                    orders.append(Order(id: orderId, orderedTeasArray: teaItems))
                }
                
                completion(orders.sorted(by: { $0.id > $1.id }))
                
            } catch {
                errorHandler("Failed to fetch orders: \(error)")
                completion([])
            }
        }
    }
    
    func readFirestore(completion: @escaping ([Review]) -> (), errorHandler: @escaping (String) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }
        
        let usersRef = store.collection(UsersFirebaseFields.path.rawValue)
        let reviewRef = usersRef.document(uid).collection(ReviewsFirebaseFields.reviewsCollection.rawValue)
        
        Task {
            do {
                let snapshot = try await reviewRef.getDocuments()
                var reviews: [Review] = []
                
                for reviewDocument in snapshot.documents {
                    guard let reviewId = reviewDocument.get(ReviewsFirebaseFields.reviewId.rawValue) as? String,
                          let review = reviewDocument.get(ReviewsFirebaseFields.review.rawValue) as? String,
                          let reviewDate = reviewDocument.get(ReviewsFirebaseFields.reviewDate.rawValue) as? String,
                          let teaName = reviewDocument.get(ReviewsFirebaseFields.teaName.rawValue) as? String,
                          let teaId = reviewDocument.get(ReviewsFirebaseFields.teaId.rawValue) as? Int else {
                        errorHandler("Warning: Missing data for review \(reviewDocument.documentID)")
                        continue
                    }
                    
                    reviews.append(Review(id: reviewId, review: review, reviewDate: reviewDate, teaName: teaName, teaId: teaId))
                }
                completion(reviews)
                
            } catch {
                errorHandler("Failed to fetch orders: \(error)")
                completion([])
            }
        }
    }
    
    func readFirestoreForAllUsers(completion: @escaping ([Review]) -> (), errorHandler: @escaping (String) -> ()) {
        
        let usersRef = store.collection(UsersFirebaseFields.path.rawValue)
        
        Task {
            do {
                let usersSnapshot = try await usersRef.getDocuments()
                var reviews: [Review] = []
                
                for user in usersSnapshot.documents {
                    let reviewRef = user.reference.collection(ReviewsFirebaseFields.reviewsCollection.rawValue)
                    let reviewsSnapshot = try await reviewRef.getDocuments()
                    
                    for reviewDocument in reviewsSnapshot.documents {
                        guard let reviewId = reviewDocument.get(ReviewsFirebaseFields.reviewId.rawValue) as? String,
                              let review = reviewDocument.get(ReviewsFirebaseFields.review.rawValue) as? String,
                              let reviewDate = reviewDocument.get(ReviewsFirebaseFields.reviewDate.rawValue) as? String,
                              let teaName = reviewDocument.get(ReviewsFirebaseFields.teaName.rawValue) as? String,
                              let teaId = reviewDocument.get(ReviewsFirebaseFields.teaId.rawValue) as? Int else {
                            errorHandler("Warning: Missing data for review \(reviewDocument.documentID)")
                            continue
                        }
                        
                        reviews.append(Review(id: reviewId, review: review, reviewDate: reviewDate, teaName: teaName, teaId: teaId))
                    }
                    
                }
                completion(reviews)
                
            } catch {
                errorHandler("Failed to fetch orders: \(error)")
                completion([])
            }
        }
    }
}
