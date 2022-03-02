//
//  AccesstokenRequest.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

struct AccesstokenRequest: Encodable {
    let client_id: String
    let client_secret: String
    let code: String
}
