//
//  UserRowView.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 2/1/25.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    let name: String = ""
    let location: String = ""
    let avatarUrl: String = ""
    
    var isDetailScren = false
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { avatar in
                avatar.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.login)
                    .font(.headline)
                
                Divider()
                
                HStack {
                    if isDetailScren {
                        Image("location-on", bundle: .main)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                        
                    Text("[\(user.url)](user.url)")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    UserRowView(user: User.mockUsers[0])
}
