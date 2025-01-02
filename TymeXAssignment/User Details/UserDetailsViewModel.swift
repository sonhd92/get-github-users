//
//  UserDetailsViewModel.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 1/1/25.
//

import Combine

class UserDetailsViewModel: ObservableObject {
    @Published var userDetails: UserDetails?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func loadUserDetails(username: String) async {
        isLoading = true
        
        do {
            userDetails = try await service.fetchUserDetails(username: username)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
