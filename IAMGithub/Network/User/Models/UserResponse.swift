//
//  UserResponse.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

struct UserResponse: Codable {
    let username: String
    let avatarURL: String
    let url: String
    let starredURL: String
    let name: String?
    let bio: String?
    let followers: Int
    let following: Int

    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
        case url
        case starredURL = "starred_url"
        case name, bio
        case followers, following
    }
}
