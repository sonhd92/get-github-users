//
//  UserDetailsView.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 1/1/25.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject private var viewModel: UserDetailsViewModel
    let username: String
    let user: User
    
    init(username: String, user: User, service: ServiceProtocol) {
        self.username = username
        self.user = user
        _viewModel = StateObject(wrappedValue: UserDetailsViewModel(service: service))
    }

    var body: some View {
        ScrollView {
            if let details = viewModel.userDetails {
                VStack(alignment: .leading, spacing: 16) {
                    UserRowView(user: user, location: details.location ?? "", isDetailScren: true)

                    HStack {
                        StatsView(type: .followers, value: details.followers)
                        StatsView(type: .following, value: details.following)
                    }
                    .padding(.top, 10)
                    
                    Text("Bio:")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    if let bio = details.bio {
                        Text(bio)
                            .font(.body)
                            .padding(.top, 16)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .task {
            await viewModel.loadUserDetails(username: username)
        }
    }
}

#Preview {
    NavigationView {
        UserDetailsView(username: "SonHoang", user: User.mockUsers[0], service: MockServiceManager())
    }
}
