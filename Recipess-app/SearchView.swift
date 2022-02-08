//
//  SearchView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchText : String
    @Binding var searching : Bool
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("SearchBar"))
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $searchText) {
                    startedSearching in
                    if startedSearching {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation{
                        searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding()
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}
