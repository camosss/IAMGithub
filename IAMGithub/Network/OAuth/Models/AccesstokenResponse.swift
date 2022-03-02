//
//  AccesstokenResponse.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

struct AccesstokenResponse: Codable {
    let accessToken: String
    let scope: String
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case scope
        case tokenType = "token_type"
    }
}
