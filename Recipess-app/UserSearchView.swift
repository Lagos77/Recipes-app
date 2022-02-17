//
//  UserSearchView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestoreSwift

struct UserSearchView: View {
    
    
    @State var logutOption = false
    @ObservedObject var currentUser = CurrentUserViewModel()
    
    @State var searchText = ""
    @State var searching = false
    @Binding var data : [dataType]
    
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
                   }
                   
                   VStack(alignment: .leading, spacing: 4){
                       Text("\(currentUser.userLogged?.username ?? "")")
                           .font(.system(size: 24, weight: .bold))
                   }
                   Spacer()
                   
                   Button {
                       logutOption.toggle()
                       print("Gear button works!")
                   } label: {
                       Image(systemName: "gear")
                           .foregroundColor(Color("ColorRed"))
                           .font(.system(size: 20, weight: .bold))
                           .padding(.horizontal, 10)
                   }
                   
               }
                    .actionSheet(isPresented: $logutOption) {
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
                VStack(alignment: .leading) {
                    SearchView(searchText: $searchText, searching: $searching)
                    
                    List(self.data.filter{$0.title.lowercased().contains(self.searchText.lowercased())}) {i in
                    
                        NavigationLink(destination: RecipeView(data: i)) {
                            Text(i.title)
                        }.frame(height: UIScreen.main.bounds.height / 15)
                    }
                    
                   /*
                    List{
                        if self.searchText != ""{
                            if self.data.filter({$0.title.lowercased().contains(self.searchText.lowercased())}).count == 0 {
                                
                                Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                                
                            } else {
                                

                            }
                        }//if ends here
                    }//List ends here
                    */
                    
                 /*
                     List{
                         ForEach(food.filter({ (foods: String) -> Bool in
                            return foods.hasPrefix(searchText) || searchText == ""
                        }),id: \.self) {food in
                            Text(food)
                        }
                    }
                    */
                                     
                }.gesture(DragGesture()
                            .onChanged({ _ in
                    UIApplication.shared.dismissKeyboard()
                })
                )
                   .listStyle(GroupedListStyle())
                   .navigationTitle("Recipe search")
                   .toolbar {}
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
    
   /*
    func checkForUser(data: dataType) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        let userDocRef = FirebaseManager.shared.firestore.collection("users").document(uid)
        let idDoc = FirebaseManager.shared.firestore.collection("recipe").document("uid")
        
        if userDocRef == idDoc {
            NavigationLink(destination: RecipeView(data: data)) {
                Text(data.title)
            }.frame(height: UIScreen.main.bounds.height / 15)
            return
        }
        
        NavigationLink(destination: RecipeOnlyView()) {
            Text(data.title)
        }.frame(height: UIScreen.main.bounds.height / 15)
    }
    */


extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class getData : ObservableObject {
    @Published var datas = [dataType]()
    
    
    init(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("recipes").addSnapshotListener { (snap, error) in
            guard let snap = snap else {return}
            
            if error != nil{
                print(error ?? "")
                return
            }
            for documents in snap.documents{
                
                let id = documents.documentID
                let url = documents.get("recipeImage") as? String ?? ""
                let title = documents.get("title") as? String ?? ""
                let description = documents.get("description") as? String ?? ""
                let recipe = documents.get("recipeText") as? String ?? ""
                
                self.datas.append(dataType(id: id, url: url, title: title, description: description, recipe: recipe))
            }
        }
    }
}

struct dataType: Identifiable, Codable {

    @DocumentID var id : String?
    var url : String
    var title : String
    var description : String
    var recipe : String
}

struct RecipeOnlyView : View {
    
    var body: some View {
        Text("You are into a new view now!")
    }
}

/*
struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}
 */
 

