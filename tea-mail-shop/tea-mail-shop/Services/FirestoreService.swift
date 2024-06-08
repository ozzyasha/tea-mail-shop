//
//  FirestoreService.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 6.06.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine

class FirestoreService: ObservableObject {
    
    private init() { return }
    static let shared = FirestoreService()
    
    private let path: String = "users"
    private let username: String = "username"
    private let email: String = "e-mail"
    private let store = Firestore.firestore()
    
    func writeFirestore(username: String) {
        let usersRef = store.collection(path)
        
        usersRef.document("\(Auth.auth().currentUser?.uid ?? "undefined")").setData([  // try userRef.addDocument(from: username)
            self.username: username,
            self.email: Auth.auth().currentUser?.email ?? "can't receive an email"
        ])
    }
    
    func readFirestore(completion: @escaping (String) -> ()) {
        
        Task { @MainActor in
            do {
                let snapshot = try await store.collection(path).getDocuments()
                for document in snapshot.documents {
                    if document.documentID == Auth.auth().currentUser?.uid {
                        completion("\(document.data()[self.username] ?? "nil")")
                        return
                    } else {
                        let displayName = Auth.auth().currentUser?.displayName
                        completion(displayName ?? "nil")
                    }
                }
            } catch {
                completion("nil")
            }
        }
    }
}
