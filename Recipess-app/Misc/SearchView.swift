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
    @State var text = ""
    //@Binding var data : [dataType]
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("SearchBar"))
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $searchText){
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
                
                if self.text != "" {
                    Button {
                        self.text = ""
                    } label: {
                        Text("Cancel")
                    }
                    .foregroundColor(.black)
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
