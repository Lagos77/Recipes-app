//
//  UserProfile.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfile: View {
    
    @State var username = ""
    @ObservedObject var currentUser = CurrentUserViewModel()
    @ObservedObject var viewModel = getData()
    
    var body: some View {
        NavigationView{
            HStack(spacing: 70){
                VStack{
                    VStack{
                        
                        WebImage(url: URL(string: currentUser.userLogged?.profileImageURL ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 33)
                                        .stroke(Color(.label),
                                                lineWidth: 1))
                            .shadow(radius: 5)
                        
                        //Image(systemName: "person.circle")
                        //    .font(.system(size: 100))
                        //    .padding(.horizontal, 10)
                    }
                    VStack{
                        Text("\(currentUser.userLogged?.username ?? "")")
                            .font(.system(size: 30, weight: .bold))
                            .padding(.horizontal, 10)
                    }
                    VStack(alignment: .leading){
                        Text("Created recipes :")
                            .font(.system(size: 20))
                            .bold()
                            .padding(.horizontal, 10)
                        VStack{
                            
                            List(viewModel.datas) { recipe in
                                VStack{
                                    Text(recipe.title).font(.title)
                                        .foregroundColor(Color("ColorRed"))
                                    
                                }.frame(height: UIScreen.main.bounds.height / 20)
                                
                            }
                            
                        }
                        
                        
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}



struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

