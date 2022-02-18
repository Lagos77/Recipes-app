//
//  CreateRecipeView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct CreateRecipeView: View {
    
    @State var titleRecipe = ""
    @State var recipeInstructions = ""
    @State var descriptionText = ""
    
    @State var saveRecipe = false
    
    @State var changeRecipePhoto = false
    @State var openCamera = false
    @State var imageSelected = UIImage()
    
    var body: some View {
            VStack{
                Text("Title")
                HStack{
                    TextEditor(text: $titleRecipe)
                        .disableAutocorrection(true)
                        .font(.title3)
                        .frame(height: 35)
                        .cornerRadius(10)
                        .padding(.horizontal, 60)
                        .shadow(radius: 2)
                }
                HStack{
                    Button {
                        changeRecipePhoto = true
                        openCamera = true
                    } label: {
                        if changeRecipePhoto {
                            Image(uiImage: imageSelected)
                                .resizable()
                                .frame(width: 260, height: 200)
                                .scaledToFill()
                                .overlay(RoundedRectangle(cornerRadius: 3)
                                            .stroke(Color.black, lineWidth: 2))
                            
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 260, height: 200)
                                .foregroundColor(.black)
                        }
                    }
                }
                .sheet(isPresented: $openCamera) {
                    ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)}
                Text("Description")
                HStack{
                    TextEditor(text: $descriptionText)
                        .disableAutocorrection(true)
                        .frame(height: 60)
                        .cornerRadius(5)
                        .padding(.horizontal, 15)
                        .shadow(radius: 3)
                }
                Text("Recipe")
                HStack{
                    TextEditor(text: $recipeInstructions)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .frame(height: 270)
                        .cornerRadius(5)
                        .padding(.horizontal, 15)
                        .shadow(radius: 3)
                }
                Button {
                    createRecipe()
                } label: {
                    Text("Save")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 25)
                        .background(Color("ColorRed"))
                        .cornerRadius(30)
                        .shadow(radius: 10)
                }
            }.alert(isPresented: $saveRecipe, content: {
                alertSave()
            })
    }
    
    private func createRecipe() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
           let ref = FirebaseManager.shared.storage.reference(withPath: uid)
            
            guard let imageData = self.imageSelected.jpegData(compressionQuality: 0.5) else {return}
            
            ref.putData(imageData, metadata: nil) { metadata, error in
                if error != nil {
                    return
                }
                ref.downloadURL { url, err in
                    if err != nil {
                        return
                    }
                    print("Sucessfully stored with URL")
                    guard let url = url else {return}
                    recipeData(recipeImageURL: url)
                }
            }
        }
    
    private func recipeData(recipeImageURL: URL){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let recipeData = ["uid": uid,"title": self.titleRecipe,"recipeImage": recipeImageURL.absoluteString ,"description": self.descriptionText, "recipeText": self.recipeInstructions]
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("recipes").document(titleRecipe).setData(recipeData) { err in
            if let err = err {
                print(err)
                return
            }
            print("Recipe data sucessfully uploaded")
            self.saveRecipe = true
        }
    }
    
    private func alertSave() -> Alert{
        return Alert(title: Text("Sucessful!"), message: Text("Your recipe is now created!"), dismissButton: .default(Text("OK")))
    }
    
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
