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
                            .cornerRadius(100)
                    } else {
                        Image(systemName: "person.fill")
                            .font(.system(size: 150))
                            .padding()
                            .foregroundColor(.black)
                    }
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 100)
                                                    .stroke(Color.black, lineWidth: 5))
                .sheet(isPresented: $openCamera) {
                    ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)

            }
                .padding(.vertical, 50)

            VStack{
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 40)
                
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 40)
                
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 40)
            }
            
            HStack{
                Button(action: {
                    createAccount()
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
    
    func createAccount(){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("Failed to create user")
                //Alertmessage
                return
            }
            print("User created!")
            self.imageToStorage()
            return
        }
    }

    private func imageToStorage() {
       // let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
       let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
        guard let imageData = self.imageSelected.jpegData(compressionQuality: 0.5) else {return}
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if error != nil {
                print("Failed to push image to Storage: \(error)")
                return
            }
            ref.downloadURL { url, err in
                if err != nil {
                    print("Failed to retrive dowload URL: \(err)")
                    return
                }
                print("Sucessfully stored with URL")
            }
        }
    }
}

struct RegisterUserView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUserView()
    }
}
