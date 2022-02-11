//
//  UserSearchView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserSearchView: View {
    
    @State var logutOption = false
    @ObservedObject var currentUser = CurrentUserViewModel()
    
    let food = [
        "Pasta", "Lasagna", "Pizza", "Rice", "Potato", "Noddles", "ca", "Meat", "Chicken", "Fish", "Mushroom"]
    
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack(spacing: 5){
                    NavigationLink {
                        UserProfile()
                    } label: {
                        
                        WebImage(url: URL(string: currentUser.userLogged?.profileImageURL ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipped()
                            .cornerRadius(20)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color(.label),
                                                lineWidth: 1))
                            .shadow(radius: 5)
                            .padding(.horizontal, 10)
                        
                        // Image(systemName: "person.fill")
                        //     .foregroundColor(Color("ColorRed"))
                        //     .font(.system(size: 35, weight: .heavy))
                        //     .padding(.horizontal, 5)
                    }
                    VStack(alignment: .leading, spacing: 4){
                        Text("\(currentUser.userLogged?.username ?? "")")
                            .font(.system(size: 24, weight: .bold))
                    }
                    Spacer()
                    VStack{
                        Button {
                            logutOption.toggle()
                            print("Gear button works!")
                        } label: {
                            Image(systemName: "gear")
                                .foregroundColor(Color("ColorRed"))
                                .font(.system(size: 20, weight: .bold))
                                .padding(.horizontal, 10)
                        }
                    }.actionSheet(isPresented: $logutOption) {
                        .init(title: Text("Settings"), message: Text("Do you want to sign out?"), buttons: [
                            .destructive(Text("Sign out"), action: {
                                print("Sign out current user!")
                                currentUser.signOut()
                            }),
                            .cancel()
                        ])
                    }
                    .fullScreenCover(isPresented: $currentUser.currentUserIsLoggedOut, onDismiss: nil) {
                        ContentView()
                    }
                }
                VStack(alignment: .leading) {
                    SearchView(searchText: $searchText, searching: $searching)
                    List{
                        ForEach(food.filter({ (foods: String) -> Bool in
                            return foods.hasPrefix(searchText) || searchText == ""
                        }),id: \.self) {food in
                            Text(food)
                        }
                    }
                    .gesture(DragGesture()
                                .onChanged({ _ in
                        UIApplication.shared.dismissKeyboard()
                    })
                    )
                    .listStyle(GroupedListStyle())
                    .navigationTitle("Recipe search")
                    .toolbar {}
                }
            }
            .overlay(
                NavigationLink(destination: {
                    CreateRecipeView()
                }, label: {
                    HStack{
                        Spacer()
                        Text("Create recipes")
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .background(Color("ColorRed"))
                    .cornerRadius(32)
                    .padding(.horizontal)
                    .shadow(radius: 15)
                }), alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}
