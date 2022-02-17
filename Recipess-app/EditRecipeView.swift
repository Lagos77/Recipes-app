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
    //@Binding var data: dataType
    
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
                            .scaledToFill()
                            .frame(width: 260, height: 200)
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
                    //Function for update
                    print("Edit is saved!")
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
                    //Fucntion for delete
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
        }
    }
    
//------------------------
// Function for delete
// Function for update
//------------------------
    
 /*
    private func deleteRecipe(recipeID : String) {
        FirebaseManager.shared.firestore.collection("recipe")
            .whereField("id", isEqualTo: recipeID).getDocuments{(snap, err) in
                if err != nil {
                    print("err")
                    return
                }
                
                for i in snap!.documents {
                    DispatchQueue.main.async {
                        i.reference.delete()
                    }
                }
                presentationMode.wrappedValue.dismiss()
            }
        
    }
  */
 
/*
    private func updateRecipe(_ update: dataType) {
        if let recipeID = update.id {
            do {
                let _ = try FirebaseManager.shared.firestore.collection("recipe").document(recipeID)
            }
            catch{
                print(error)
            }
        }
    }
 */
    
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView()
    }
}
