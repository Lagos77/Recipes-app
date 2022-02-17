//
//  EditRecipeView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-16.
//

import SwiftUI

struct EditRecipeView: View {
    
    @State var titleRecipe = "Enter title"
    @State var recipeInstructions = "Write your recipe here..."
    @State var descriptionText = "Write description for the recipe..."
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var changeRecipePhoto = false
    @State var openCamera = false
    @State var imageSelected = UIImage()
    @State var data: dataType
    
    var body: some View{
        VStack{
            HStack{
                TextEditor(text: $titleRecipe)
                    .disableAutocorrection(true)
                    .font(.title3)
                    .frame(height: 40)
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
                            .frame(width: 260, height: 200)
                            .scaledToFill()
                            .foregroundColor(.black)
                        
                    }
                }
            }
            .sheet(isPresented: $openCamera) {
                ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)}
            
            HStack{
                TextEditor(text: $descriptionText)
                    .disableAutocorrection(true)
                    .frame(height: 60)
                    .cornerRadius(5)
                    .padding(.horizontal, 15)
                    .shadow(radius: 3)
            }
            HStack{
                
                TextEditor(text: $recipeInstructions)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(height: 310)
                    .cornerRadius(5)
                    .padding(.horizontal, 15)
                    .shadow(radius: 3)
            }
            HStack{
                Button {
                    editImage()
                    //updateRecipe()
                } label: {
                    Text("Save Edit")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 25)
                        .background(Color("ColorRed"))
                        .cornerRadius(30)
                        .shadow(radius: 10)
                }
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Exit Edit")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 25)
                        .background(Color("ColorRed"))
                        .cornerRadius(30)
                        .shadow(radius: 10)
                }
                
            }.padding()
            HStack{
                Button {
                    deleteRecipe(recipeID: data.id)
                    print("Recipe deleted")
                } label: {
                    Text("Delete".uppercased())
                        .font(.caption)
                        .bold()
                        .foregroundColor(.gray)
                        .padding()
                        .padding(.horizontal, 10)
                    .background(Capsule().stroke(Color.gray, lineWidth: 1.0))                }
            }
            .padding()
        }.onAppear(){
            titleRecipe = data.title
            descriptionText = data.description
            recipeInstructions = data.recipe
        }
    }
    
    //------------------------
    // Function for delete
    // Function for update
    //------------------------
    
    
    private func deleteRecipe(recipeID : String?) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        guard let id = recipeID else {return}
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("recipes").document(id).delete()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func editImage() {
        print("Starting editImage function David")
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        print("Read uid editImage David")
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
        guard let imageData = self.imageSelected.jpegData(compressionQuality: 0.5) else {return}
        print("passing imageData editImage function David")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if error != nil {
                print("Error putData imageData editImage function David")
                return
            }
            ref.downloadURL { url, err in
                if err != nil {
                    print("ref.downloadURL error editImage fucntion David")
                    return
                }
                print("Sucessfully stored with URL")
                guard let url = url else {return}
                editRecipe(recipeImageURL: url)
            }
        }
    }
    
    private func editRecipe(recipeImageURL: URL){
        print("Starting editRecipe function David")
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        print("Read uid ediptRecipe David")
        
        let recipeData = ["uid": uid,"title": self.titleRecipe,"recipeImage": recipeImageURL.absoluteString ,"description": self.descriptionText, "recipeText": self.recipeInstructions]
        
        print("recipeData \(recipeData["description"]) David")
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("recipes").document(titleRecipe).setData(recipeData) { err in
            if let err = err {
                print("Error during update of recipe David: \(err)")
                return
            }
            print("Recipe data sucessfully uploaded David")
            presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let id = "id"
        let url = "Photo"
        let title = "Title"
        let description = "Description text.."
        let recipe = "Recipe here"
        
        EditRecipeView(data: dataType(id: id , url: url, title: title, description: description, recipe: recipe))
    }
}
