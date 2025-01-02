//
//  UserDetails.swift
//  TymeXAssignment
//
//  Created by Son Hoang Duc on 1/1/25.
//

struct UserDetails: Codable {
    let name: String?
    let bio: String?
    let followers: Int
    let following: Int
    let publicRepos: Int
    let location: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case bio
        case followers
        case following
        case publicRepos = "public_repos"
        case location
    }
}

extension UserDetails {
    static let mockUserDetails = UserDetails(
        name: "Son Hoang Duc",
        bio: "Software Engineer",
        followers: 100,
        following: 200,
        publicRepos: 300,
        location: "Ho Chi Minh City"
    )
}
