//
//  RegisterUserView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct RegisterUserView: View {
    
    @State var changeProfilePicture = false
    @State var openImagePicker = false
    @State var imageSelected = UIImage()
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var showAlert = false
    @State var errorAlert = false
    @State var alertShow = false
    
    var body: some View {
        
        NavigationView{
            VStack{
                VStack{
                    Button {
                        changeProfilePicture = true
                        openImagePicker = true
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
                .sheet(isPresented: $openImagePicker) {
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
                        withAnimation {
                        }
                        
                    }, label: {
                        Text("Register".uppercased())
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                            .padding()
                            .padding(.horizontal, 10)
                            .background(Capsule().stroke(Color.gray, lineWidth: 1.0))
                    })
                }
                .alert(isPresented: $alertShow, content:  {
                    alertEnabler()
                })
                .padding(.top, 80)
            }.navigationBarHidden(true)
        }
    }
    
    func createAccount(){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("Failed to create user")
                self.alertShow = true
                self.showAlert = false
                self.errorAlert = true
                return
            }
            print("User created!")
            self.imageToStorage()
            return
        }
    }
    
    private func imageToStorage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
        guard let imageData = self.imageSelected.jpegData(compressionQuality: 0.5) else {return}
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if error != nil {
                self.alertShow = true
                self.showAlert = false
                self.errorAlert = true
                return
            }
            ref.downloadURL { url, err in
                if err != nil {
                    self.alertShow = true
                    self.showAlert = false
                    self.errorAlert = true
                    return
                }
                print("Sucessfully stored with URL")
                guard let url = url else {return}
                userDataStore(imageProfileURL: url)
            }
        }
    }
    
    private func userDataStore(imageProfileURL: URL){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let userData = ["email": self.email, "username": self.username, "uid": uid, "profileImageURL": imageProfileURL.absoluteString]
        FirebaseManager.shared.firestore.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print(error)
                self.alertShow = true
                self.showAlert = false
                self.errorAlert = true
                return
                
            }
            print("User collection successfully created!")
            self.errorAlert = false
            self.showAlert = true
            self.alertShow = true
        }
    }
    
    private func regAlert() -> Alert {
        return Alert(title: Text("Registration successful"),
                     message: Text("You can now login with your new account"),
                     dismissButton: .default(Text("Got it!")))
    }
    
    private func errAlert() -> Alert {
        return Alert(title: Text("Registration failed"),
                     message: Text("An error occurred during registration. Failed to create user "), dismissButton: .default(Text("OK")))
    }
    
    private func alertEnabler() -> Alert {
        if errorAlert == true {
            return errAlert()
        } else if showAlert == true {
            return regAlert()
        }
        return alertEnabler()
    }
}

struct RegisterUserView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUserView()
    }
}
