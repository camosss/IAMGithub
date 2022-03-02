//
//  UserResponse.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

struct UserResponse: Codable {
    let login: String
    let avatarURL: String
    let url: String
    let starredURL: String
    let name: String?
    let bio: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case url
        case starredURL = "starred_url"
        case name, bio
    }
}
