//
//  CurrentUserViewModel.swift
//  Recipess-app
//
//  Created by A J on 2022-02-10.
//

import Foundation

class CurrentUserViewModel: ObservableObject{
    
    @Published var userLogged : User?
    
    init() {
        DispatchQueue.main.async {
            self.currentUserIsLoggedOut =
            FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        
        currentUser()
    }
    
    private func currentUser(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if error != nil {
                print("Failed")
                return
            }
            guard let data = snapshot?.data() else {return}
            
            let uid = data["uid"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageURL = data["profileImageURL"] as? String ?? ""
            self.userLogged = User(uid: uid, username: username, email: email, profileImageURL: profileImageURL)
        }
    }
    
    @Published var currentUserIsLoggedOut = false
    
    func signOut() {
        currentUserIsLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}

struct User {
    let uid, username, email, profileImageURL : String
}
