//
//  UserListView.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 1/1/25.
//

import SwiftUI
import UIKit

struct UserListView: View {
    // USing @StateObject to keep the view model to maintain the state across view redraw.
    @StateObject private var viewModel: UserViewModel
    
    init(service: ServiceProtocol) {
        _viewModel = StateObject(wrappedValue: UserViewModel(services: service))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.user) { user in
                        NavigationLink(value: user) {
                            UserRowView(user: user, location: "")
                                .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    if !viewModel.user.isEmpty {
                        ProgressView().frame(maxWidth: .infinity)
                            .padding()
                            .onAppear {
                                Task {
                                    await viewModel.loadMore()
                                }
                            }
                    }
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.lightGray.withAlphaComponent(0.4)))
            .navigationTitle("Github Users")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self) { user in
                UserDetailsView(username: user.login, user: user, service: viewModel.services)
            }
            .overlay {
                if viewModel.user.isEmpty && viewModel.isLoading {
                    ProgressView()
                }
            }
            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
                Button("Retry") {
                    Task {
                        await viewModel.fetchInitUsers()
                    }
                }
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.error?.localizedDescription ?? "Unknow error")
            }

        }
    }
}

#Preview {
    UserListView(service: MockServiceManager())
}
