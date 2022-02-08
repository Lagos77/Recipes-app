//
//  RegisterUserView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct RegisterUserView: View {
    
    @State var changeProfilePicture = false
    @State var openCamera = false
    @State var imageSelected = UIImage()
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var name = ""
    
    var body: some View {
        
        VStack{
            VStack{
                Button {
                    changeProfilePicture = true
                    openCamera = true
                    
                } label: {
                    if changeProfilePicture {
                        Image(uiImage: imageSelected)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.black)
                            .padding(.bottom, 100)
                    } else {
                        Image(systemName: "person.crop.square")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.black)
                            .padding(.bottom, 100)
                    }
                }

            }.sheet(isPresented: $openCamera) {
                ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
            }
//            HStack{
//
//                Text("Enter your information below and select an avatar")
//                    .font(.title)
//                    .bold()
//                    .foregroundColor(Color("ColorRed"))
//                    .padding()
//            }
            VStack{
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 40)
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 40)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 40)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 40)
            }
            
            HStack{
                Button(action: {
                    //verification()
                }, label: {
                    Text("Register".uppercased())
                        .font(.caption)
                        .bold()
                        .foregroundColor(.gray)
                        .padding()
                        .padding(.horizontal, 10)
                        .background(Capsule().stroke(Color.gray, lineWidth: 1.0)
                        )
                })
                
            }.padding(.top, 80)
        }
        
    }
/*    func verification() {
        //Controls if all data is written
        //Verifies if password == re-password
        //Adds information to firebase
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                return
            }
            imageToStorage()
            print("User created")
        }
    }
 */
    private func imageToStorage() {
        
    }
}

struct RegisterUserView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUserView()
    }
}
