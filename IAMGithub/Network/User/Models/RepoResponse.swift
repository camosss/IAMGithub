//
//  RepoResponse.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/30.
//

import Foundation

typealias UserRepoResponse = [Repository]
typealias UserStarredRepoResponse = [Repository]

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let pushedAt: String
    let description: String?
    let stargazersCount: Int
    let forksCount: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case name, description
        case fullName = "full_name"
        case owner
        case pushedAt = "pushed_at"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case url = "html_url"
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

extension Repository: Equatable, Identifiable {
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
}
