//
//  AuthService.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 8.06.24.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics
import FirebaseCrashlyticsSwift
import FirebaseAuth
import GoogleSignIn
import Combine

class AuthViewModel: ObservableObject {
    
    @Published 
    var authState: AuthState = .unauthenticated
    @Published 
    var errorMessage: String?
    @Published 
    var currentUsername = String()
    @ObservedObject
    var firestore = FirestoreService()
    
    private var cancellables: [AnyCancellable] = []
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.authState = .authenticated
            } else {
                self.authState = .unauthenticated
            }
        }
        
        firestore.$teamailUser.sink { [weak self] user in
            guard let user = user else { return }
            self?.currentUsername = user.username
        }.store(in: &cancellables)
    }
    
    func signUpWithEmail(email: String, username: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                self.errorMessage = "Sign Up error: \(error?.localizedDescription ?? "Undefined error")"
                return
            }
            self.firestore.readFirestore { user in
                self.firestore.writeFirestore(username: user?.username ?? username)
            }
            self.signInWithEmail(email: email, password: password)
            
        }
        Analytics.logEvent("sign_up", parameters: nil)
    }
    
    func signInWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                self.errorMessage = "Sign In error: \(error?.localizedDescription ?? "Undefined error")"
                return
            }
        }
        Analytics.logEvent("login", parameters: nil)
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows
            .first?
            .rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                self.errorMessage = "Google Sign In error: \(error?.localizedDescription ?? "Undefined error")"
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if result?.user != nil {
                    self.firestore.readFirestore { user in
                        self.firestore.writeFirestore(username: (user?.username ?? result?.user.displayName) ?? "Anonymous")
                    }
                }
                
                guard error == nil else {
                    self.errorMessage = "Sign In error: \(error?.localizedDescription ?? "Undefined error")"
                    return
                }
            }
        }
        Analytics.logEvent("sign_up_google", parameters: nil)
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func updateUsername(newUsername: String) {
        currentUsername = newUsername
        firestore.writeFirestore(username: currentUsername)
    }
    
    func getCurrentUsername() -> String {
        return firestore.teamailUser?.username ?? "Anonymous"
    }
    
    func getAvatar() -> URL {
        return Auth.auth().currentUser?.photoURL ?? URL(fileURLWithPath: "")
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            if GIDSignIn.sharedInstance.hasPreviousSignIn() {
                GIDSignIn.sharedInstance.signOut()
            }
        } catch let signOutError as NSError {
            self.errorMessage = "Sign Out Error: \(signOutError.localizedDescription)"
        }
        Analytics.logEvent("sign_out", parameters: nil)
    }
    
}
