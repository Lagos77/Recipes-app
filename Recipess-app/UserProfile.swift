//
//  UserProfile.swift
//  Recipess-app
//
//  Created by A J on 2022-02-08.
//

import SwiftUI

struct UserProfile: View {
    
    @State var username = ""
    
    var body: some View {
        HStack(spacing: 70){
            VStack{
            VStack{
                Image(systemName: "person.circle")
                    .font(.system(size: 100))
                    .padding(.horizontal, 10)
            }
                VStack{
                    Text("Username")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.horizontal, 10)
                }
                VStack(alignment: .leading){
                    Text("Created recipes :")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.horizontal, 10)
                    ScrollView{
                        VStack{
                            ForEach(0..<20) { index in Rectangle()
                                    .fill(Color("ColorRed"))
                                    .frame(height: 100)
                            }
                        }
                    }
                }
                VStack(alignment: .leading){
                    Text("Saved recipes :")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.horizontal, 10)
                    ScrollView{
                        VStack{
                            ForEach(0..<20) { index in Rectangle()
                                    .fill(Color.blue)
                                    .frame(height: 100)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
