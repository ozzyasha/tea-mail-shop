//
//  UsersViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//
//
import Combine

//class UsersViewModel: ObservableObject {
//    
//    private var cancellable: [AnyCancellable] = []
//    @Published
//    var user: User?
//    // 3
//    //    @Published var firestoreService = FirestoreService()
//    
//    //    // 4
//    //
//    //    private var user = user.userPublisher
//    
//    func bindUser(completion: @escaping (Int) -> ()) {
//        user.sink(receiveCompletion: {_ in}) { value in
//            completion(value)
//            
//        }.store(in: &cancellable)
//    }
//    
//    func changeUser(email: String, password: String) {
//        user.send(self.user.value = User(email: email, password: password))
//    }
//    
//    func addUserToFirestore(_ user: User) {
//        FirestoreService.writeFirestore(username: user.email)
//    }
//    
//    func receiveUserEmail() {
//        
//    }
//}
