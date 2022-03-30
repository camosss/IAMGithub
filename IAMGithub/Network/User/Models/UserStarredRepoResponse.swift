//
//  UserStarredRepoResponse.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/30.
//

import Foundation

typealias UserStarredRepoResponse = [Item]

struct Item: Codable {
    let name: String
    let fullName: String
    let owner: Owner
    let pushedAt: String
    let itemDescription: String?
    let stargazersCount: Int

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case owner
        case itemDescription = "description"
        case pushedAt = "pushed_at"
        case stargazersCount = "stargazers_count"
    }
}

struct Owner: Codable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

