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
    
    init(username: String, service: ServiceProtocol) {
        self.username = username
        _viewModel = StateObject(wrappedValue: UserDetailsViewModel(service: service))
    }

    var body: some View {
        ScrollView {
            if let details = viewModel.userDetails {
                VStack(alignment: .leading, spacing: 16) {
                    Text(details.name ?? "")
                        .font(.title)
                    
                    if let bio = details.bio {
                        Text(bio)
                            .font(.body)
                    }
                    
                    HStack {
                        StatsView(title: "Followers", value: details.followers)
                        StatsView(title: "Following", value: details.following)
                    }
                    
                    if let location = details.location {
                        Text("Location: \(location)")
                            .font(.caption)
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
        UserDetailsView(username: "SonHoang", service: MockServiceManager())
    }
}
