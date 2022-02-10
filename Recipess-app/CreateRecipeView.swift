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
    
    var body: some View {
        VStack{
        VStack{
        TextField("Enter title", text: $titleRecipe)
                .padding()
                .font(.headline)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(30)
                .padding(.horizontal, 10)

        }
        .padding(.vertical, 15)
            VStack{
                Image(systemName: "photo")
                    .font(.system(size: 180))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                Text("Press for upload photo")
                    .font(.system(size: 20, weight: .bold))
            }
            VStack{
                TextEditor(text: $descriptionText)
                    .frame(height: 60)
                    .cornerRadius(5)
                    .shadow(radius: 3)
            }
            VStack{

                TextEditor(text: $recipeInstructions)
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
