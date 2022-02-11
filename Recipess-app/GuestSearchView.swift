//
//  GuestSearchView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct GuestSearchView: View {
    
    let food = [
        "Pasta", "Lasagna", "Pizza", "Rice", "Potato", "Noddles", "ca", "Meat", "Chicken", "Fish", "Mushroom"]
    
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    VStack(alignment: .center, spacing: 4){
                        Text("Welcome guest")
                            .font(.system(size: 24, weight: .heavy))
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
            .navigationBarHidden(true)
        }
        
    }
}

struct GuestSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GuestSearchView()
    }
}
