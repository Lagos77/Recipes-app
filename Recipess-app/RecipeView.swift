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
    var body: some View {
        VStack{
            HStack{
                    Text(data.title)
                    .font(.title3)
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
                                .stroke(Color.black, lineWidth: 2))
            }
            
            HStack{
                    Text(data.description)
                    .frame(height: 60)
                    .cornerRadius(5)
                    .padding(.horizontal, 15)
                    //.shadow(radius: 3)
            }
            ScrollView{
            HStack{
                    Text(data.recipe)
                    .frame(height: 310)
                    .cornerRadius(5)
                    .padding(.horizontal, 15)
                    //.shadow(radius: 3)
                }
            }
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
                    //.shadow(radius: 10)
            }
        }
    }
}
                                 

