//
//  UserReposResponse.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/04.
//

import Foundation

struct UserReposResponse: Codable {
    let name: String
    let description: String?
    let pushedAt: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, description
        case pushedAt = "pushed_at"
        case url = "html_url"
    }
}
