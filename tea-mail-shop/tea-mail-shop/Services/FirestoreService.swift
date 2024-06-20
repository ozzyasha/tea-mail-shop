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
    
    private let path: String = "users"
    private let uid: String = "uid"
    private let username: String = "username"
    private let email: String = "e-mail"
    private let store = Firestore.firestore()
    private var errorMessage = ""
    
    @Published
    var teamailUser: TeamailUser?
    
    func writeFirestore(username: String) {
        let usersRef = store.collection(path)
        
        usersRef.document("\(Auth.auth().currentUser?.uid ?? "undefined")").setData([
            self.uid: Auth.auth().currentUser?.uid ?? "can't receive an id",
            self.username: username,
            self.email: Auth.auth().currentUser?.email ?? "can't receive an email"]) { err in
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
        store.collection(path).document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
            
            let uid = data[self.uid] as? String ?? ""
            let email = data[self.email] as? String ?? ""
            let username = data[self.username] as? String ?? ""
            
            self.teamailUser = TeamailUser(uid: uid, email: email, username: username)
        }
    }
    
    func readFirestore(completion: @escaping (TeamailUser?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        store.collection(path).document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                return
            }
            
            guard let data = snapshot?.data() else {
                completion(nil)
                self.errorMessage = "No data found"
                return
            }
            
            let uid = data[self.uid] as? String ?? ""
            let email = data[self.email] as? String ?? ""
            let username = data[self.username] as? String ?? ""
            
            completion(TeamailUser(uid: uid, email: email, username: username))
        }
    }
}
