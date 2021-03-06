//
//  ContentView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginModel = LoginViewModel()
    @State var isLoading = false
    
    var body: some View {
            if loginModel.isLoggedIn {
                
                UserSearchView()
            } else {
                SignIn(loginModel: loginModel)
            }
        }
    
    func startFakeNetworkCall() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
        }
    }
    
}

struct SignIn: View{
    
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var loginModel : LoginViewModel
    
    var body: some View{
        NavigationView{
            VStack(alignment: .leading, spacing: 20, content: {
                Image("foodlogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack{
                    
                    HStack{
                        Image(systemName: "envelope")
                            .font(.title2)
                            .foregroundColor(Color("ColorRed").opacity(0.5))
                            .frame(width: 35)
                        
                        TextField("Email adress", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    
                    HStack{
                        Image(systemName: "lock")
                            .font(.title2)
                            .foregroundColor(Color("ColorRed").opacity(0.5))
                            .frame(width: 35)
                        
                        SecureField("Password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    
                    
                    VStack{
                        Button {
                            loginModel.signIn(email: email, password: password)
                            
                        } label: {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal, 25)
                                .background(Color("ColorRed"))
                                .cornerRadius(30)
                                .shadow(radius: 10)
                        }
                        .padding()
                        
                        /*
                        NavigationLink(destination: GuestSearchView(), label: {
                            Text("Guest")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal, 25)
                                .background(Color("ColorRed"))
                                .cornerRadius(30)
                                .shadow(radius: 10)
                            
                        })
                        */
                            .padding(.bottom,50)
                        HStack{
                            NavigationLink(destination: RegisterUserView(), label:{
                                Text("Register")
                                    .foregroundColor(Color.red.opacity(0.9))
                            })
                        }.alert(isPresented: $loginModel.errorLog) {
                            errorLogin()
                        }
                    }
                }
            })
                .navigationTitle("Sign in")
            // .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    private func errorLogin() -> Alert {
        return Alert(title: Text("Error during login"), message: Text("Wrong email or password. Please try again."), dismissButton: .default(Text("OK")))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.5)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .scaleEffect(3)
        }
    }
}
