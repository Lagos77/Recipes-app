//
//  ContentView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SignIn()
    }
}

struct SignIn: View{
    
    @State var email = ""
    @State var password = ""
    
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
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                        
                        
                        VStack{
                            Button {
                                //loginModel.signIn(email: email, password: password)
                                //guard !email.isEmpty, !password.isEmpty else {return}
                                //firebaseManager.signIn(email: email, password: password)
                                
                                
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
                                .padding(.bottom,50)
                            HStack{
                                NavigationLink(destination: RegisterUserView(), label:{
                                    Text("Register")
                                        .foregroundColor(Color.red.opacity(0.9))
                                })
                            }
                        }
                    }
            })
                .navigationTitle("Sign in")
            // .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
