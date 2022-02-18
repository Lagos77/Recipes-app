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
    
    var body: some View {
        VStack{
            HStack{
                    Text(data.title)
                    .font(.title3)
                    .bold()
                    .frame(height: 40)
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                    //.shadow(radius: 2)
            }
            HStack{
                WebImage(url: URL(string: data.url))
                    .resizable()
                    .frame(width: 260, height: 200)
                    .scaledToFill()
                    .overlay(RoundedRectangle(cornerRadius: 3)
                                .stroke(Color("ColorRed"), lineWidth: 2))
            }
            
           
                HStack{
                    Text(data.description)
                        .frame(width: 310, height: 100)
                        .cornerRadius(5)
                        .padding(.horizontal, 15)
                }
            
            ScrollView{
                HStack{
                    Text(data.recipe)
                        .frame(width: 310, height: 350)
                        .cornerRadius(5)
                        .padding(.horizontal, 15)
                }
            }
            HStack{
                /*
                Button {
                    print("Saved to favorites")
                } label: {
                    Text("Favorite")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 25)
                        .background(Color("ColorRed"))
                        .cornerRadius(30)
                        .shadow(radius: 10)
                }
                 */
                //Spacer()
                
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
            .padding()
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

