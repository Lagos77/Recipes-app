//
//  AltSearchView.swift
//  Recipess-app
//
//  Created by A J on 2022-02-14.
//

import SwiftUI

struct AltSearchView: View {
    
    @State var data = getData()
    
    var body: some View {
        
        NavigationView{
            ZStack(alignment: .top){
                
                GeometryReader{_ in
                    //Home View
                    
                }.background(Color("SearchBar").edgesIgnoringSafeArea(.all))
                
                CustomSearchBar(data: self.$data.datas).padding(.top)
            }.navigationTitle("")
                .navigationBarHidden(true)
            
        }
    }
}

struct CustomSearchBar : View {
    
    @State var text = ""
    @Binding var data : [dataType]
    
    var body: some View{
        
        VStack(spacing: 0){
            HStack{
                TextField("Search", text: self.$text)
                
                if self.text != "" {
                    Button {
                        self.text = ""
                    } label: {
                        Text("Cancel")
                    }
                    .foregroundColor(.black)
                }
            }.padding()
            if self.text != ""{
                if self.data.filter({$0.title.lowercased().contains(self.text.lowercased())}).count == 0 {
                    Text("No Results Found").foregroundColor(Color.black.opacity(0.5))
                } else {
                    
                    List(self.data.filter{$0.title.lowercased().contains(self.text.lowercased())}) {i in
                        
                        NavigationLink(destination: Detail(data: i)) {
                            Text(i.title)
                        }
    
                        
                    }.frame(height: UIScreen.main.bounds.height / 5)
                }
            }
            
    
        }.background(.white)
        
    }
}





struct AltSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AltSearchView()
    }
}
