//
//  UserSearchViewModel.swift
//  Recipess-app
//
//  Created by Henrik Sjögren on 2022-06-07.
//

import Foundation

final class GetData : ObservableObject {
    
    @Published var datas = [dataType]()
    
    init(){
        fetchRecipes(for: "recipes")
    }
    private func fetchRecipes(for collection: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        FirebaseManager.shared.firestore.collection("users").document(uid).collection(collection).addSnapshotListener { (snap, error) in
            guard let snap = snap else {return}
            
            if error != nil{
                print(error ?? "")
                return
            }
            self.datas.removeAll()
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
