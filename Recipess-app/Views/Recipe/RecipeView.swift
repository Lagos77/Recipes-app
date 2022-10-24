//
//  RecipeView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-15.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeView: View {
    
    var data : dataType
    @State var showSheet = false
    
    var body: some View{
        VStack{
        ScrollView{
            AsyncImage(url: URL(string: data.url)) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                WebImage(url: URL(string: data.url))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            
            VStack(spacing: 30){
                Text(data.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 30){
                    if !data.description.isEmpty{
                        Text(data.description)
                    }
                    
                    if !data.recipe.isEmpty{
                        VStack(alignment: .leading, spacing: 20){
                            Text("Ingredients")
                                .font(.headline)
                            
                            Text(data.recipe)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 50)
            .padding(.horizontal)
            
        }
        //.ignoresSafeArea(.container, edges: .top)
            
            Button {
                showSheet.toggle()
            } label: {
                Text("Edit")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 25)
                    .background(Color("ColorRed"))
                    .cornerRadius(30)
                    .shadow(radius: 10)
            }
            .fullScreenCover(isPresented: $showSheet,content: {EditRecipeView(data: data)})
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let id = "id"
        let url = "Photo"
        let title = "Title"
        let description = "Description text.."
        let recipe = "Recipe here"
        
        RecipeView(data: dataType(id: id, url: url, title: title, description: description, recipe: recipe))
    }
}
