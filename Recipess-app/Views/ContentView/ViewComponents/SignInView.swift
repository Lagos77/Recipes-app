//
//  SignInView.swift
//  Recipess-app
//
//  Created by Henrik Sjögren on 2022-06-07.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var loginModel : LoginViewModel
    
    var body: some View {
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
        }
    }
    private func errorLogin() -> Alert {
        return Alert(title: Text("Error during login"), message: Text("Wrong email or password. Please try again."), dismissButton: .default(Text("OK")))
    }
}



//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
