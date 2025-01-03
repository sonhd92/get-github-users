//
//  ServiceManager.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 1/1/25.
//

import Foundation

protocol ServiceProtocol {
    func fetchUser(since: Int, perPage: Int) async throws -> [User]
    func fetchUserDetails(username: String) async throws -> UserDetails
}

class ServiceManager: ServiceProtocol {
    func fetchUser(since: Int, perPage: Int) async throws -> [User] {
        let url = URL(string: "https://api.github.com/users?per_page=\(perPage)&since=\(since)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func fetchUserDetails(username: String) async throws -> UserDetails {
        let url = URL(string: "https://api.github.com/users/\(username)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(UserDetails.self, from: data)
    }
}

class MockServiceManager: ServiceProtocol {
    var user: [User] = []
    var userDetails: UserDetails?
    var error: Error?
    
    func fetchUser(since: Int, perPage: Int) async throws -> [User] {
        if let error = error {
            throw error
        }
        
        return user
    }
    
    func fetchUserDetails(username: String) async throws -> UserDetails {
        if let error = error {
            throw error
        }
        
        return userDetails ?? UserDetails(name: "Test User", bio: "This is test bio", followers: 100, following: 10, publicRepos: 2, location: "Vietnam")
    }
}
