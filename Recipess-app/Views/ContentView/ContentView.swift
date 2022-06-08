//
//  ContentView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginModel = LoginViewModel()
    
    var body: some View {
        if loginModel.isLoggedIn {
            SearchView()
        } else {
            SignInView(loginModel: loginModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

