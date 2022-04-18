//
//  SearchRepoResponse.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/04/18.
//

import Foundation

struct SearchRepoResponse: Codable {
    var items: [Repository]

    enum CodingKeys: String, CodingKey {
        case items
    }
}
