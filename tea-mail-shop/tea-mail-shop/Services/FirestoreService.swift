//
//  FirestoreService.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 6.06.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FirestoreService: ObservableObject {
    
    private init() { return }
    static let shared = FirestoreService()
    
    private let path: String = "users"
    private let store = Firestore.firestore()
    
//    func add(_ card: Card) {
//        do {
//            _ = try store.collection(path).addDocument(from: card)
//        } catch {
//            fatalError("Unable to add card: \(error.localizedDescription).")
//        }
//    }
}
