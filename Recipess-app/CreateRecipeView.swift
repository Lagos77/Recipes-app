//
//  CreateRecipeView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct CreateRecipeView: View {
    
    @State var titleRecipe = ""
    @State var recipeInstructions = "Write your recipe here..."
    @State var descriptionText = "Write description for the recipe..."
    
    @State var changeRecipePhoto = false
    @State var openCamera = false
    @State var imageSelected = UIImage()
    
    var body: some View {
        VStack{
            VStack{
                TextField("Enter title", text: $titleRecipe)
                    .disableAutocorrection(true)
                    .padding()
                    .font(.headline)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(30)
                    .padding(.horizontal, 10)
            }
        .padding(.vertical, 4)
            VStack{
                Button {
                    print("Button works")
                } label: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 190, height: 170)
                        .foregroundColor(.black)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 25)
                }
            }
                VStack{
                    TextEditor(text: $descriptionText)
                        .disableAutocorrection(true)
                        .frame(height: 60)
                        .cornerRadius(5)
                        .shadow(radius: 3)
                }
                VStack{
                    
                    TextEditor(text: $recipeInstructions)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .frame(height: 310)
                        .cornerRadius(5)
                        .shadow(radius: 3)
                }
            .padding(.bottom, 5)
            VStack{
                Button {
                    //
                } label: {
                    Text("Save")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 25)
                        .background(Color("ColorRed"))
                        .cornerRadius(30)
                        .shadow(radius: 10)
                        .padding(.bottom, 30)
                }
                
            }
            .padding()
            }
            .padding()
        }
    }

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
