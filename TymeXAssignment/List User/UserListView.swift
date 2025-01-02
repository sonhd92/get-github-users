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
                            UserRowView(user: user)
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
            .navigationTitle("Github Users")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self) { user in
                UserDetailsView(username: user.login, service: viewModel.services)
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
//        NavigationStack {
//            List {
//                ForEach(viewModel.user) { user in
//                    Section {
//                        NavigationLink(value: user) {
//                            UserRowView(user: user)
//                        }
//                    }
//                    .headerProminence(.increased)
//                }
//                .listRowSeparator(.hidden)
//                
//                if !viewModel.user.isEmpty {
//                    ProgressView()
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .onAppear {
//                            Task {
//                                await viewModel.loadMore()
//                            }
//                        }
//                }
//            }
//            .navigationTitle("Github Users")
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationDestination(for: User.self) { user in
//                UserDetailsView(username: user.login, service: viewModel.services)
//            }
//            .overlay {
//                if viewModel.user.isEmpty && viewModel.isLoading {
//                    ProgressView()
//                }
//            }
//            .refreshable {
//                await viewModel.fetchInitUsers()
//            }
//            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
//                Button("Retry", action: {
//                    Task {
//                        await viewModel.fetchInitUsers()
//                    }
//                })
//                Button("OK", role: .cancel) {}
//            } message: {
//                Text(viewModel.error?.localizedDescription ?? "Unknown error")
//            }
//        }
        
//        NavigationView {
//            List {
//                ForEach(viewModel.user) { user in
//                    NavigationLink(destination: {
//                        UserDetailsView(username: user.login, service: viewModel.services)
//                    }) {
//                        UserRowView(user: user)
//                            .padding(.bottom, 10)
//                    }
//                }
//                .listRowSeparator(.hidden)
//                
//                if !viewModel.user.isEmpty {
//                    ProgressView()
//                        .onAppear {
//                            Task {
//                                await viewModel.loadMore()
//                            }
//                        }
//                }
//            }
//            .listStyle(.plain)
//            .navigationTitle("Github Users")
//            .navigationBarTitleDisplayMode(.inline)
//            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
//                Button("OK", role: .cancel) {}
//            } message: {
//                Text(viewModel.error?.localizedDescription ?? "Unknown Error")
//            }
//        }
    }
}

#Preview {
    UserListView(service: MockServiceManager())
}
