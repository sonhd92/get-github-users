//
//  UserViewModel.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 1/1/25.
//

import Combine

class UserViewModel: ObservableObject {
    @Published var user: [User] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    let services: ServiceProtocol
    private var currentPage = 0
    private let perPage = 20
    
    init(services: ServiceProtocol) {
        self.services = services
        
        Task {
            await fetchInitUsers()
        }
    }
    
    @MainActor
    func fetchInitUsers() async {
        await loadMore()
    }
    
    @MainActor
    func loadMore() async {
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
            let users = try await services.fetchUser(since: currentPage * perPage, perPage: perPage)
            print("GET USER: \(users)")
            user.append(contentsOf: users)
            currentPage += 1
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
        
}
