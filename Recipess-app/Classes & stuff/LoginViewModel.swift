//
//  LoginViewModel.swift
//  Recipess-app
//
//  Created by A J on 2022-02-10.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    func signIn(email: String, password: String) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                print("Couldn't sign in")
                return
            }
            DispatchQueue.main.async {
                self.isLoggedIn = true
                print("Signed in !")
            }
        }
    }
}
