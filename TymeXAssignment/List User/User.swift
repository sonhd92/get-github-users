//
//  User.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 1/1/25.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id = UUID()
    let login: String
    let avatarUrl: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case url
    }
}

extension User {
    static let mockUsers: [User] = [
        User(login: "SonHoangDuc", avatarUrl: "https://placehold.co/600x400/000000/FFFFFF", url: "https://api.github.com/users/johndoe"),
        User(login: "user01", avatarUrl: "https://placehold.co/600x400/orange/white", url: "https://api.github.com/users/johndoe"),
        User(login: "user02", avatarUrl: "https://placehold.co/600x400/green/red", url: "https://api.github.com/users/johndoe")
    ]
}
