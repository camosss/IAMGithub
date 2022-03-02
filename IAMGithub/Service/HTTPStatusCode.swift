//
//  HTTPStatusCode.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

enum HTTPStatusCode {
    case success
    case requiredAuth
}

extension HTTPStatusCode {
    var status: Int {
        switch self {
        case .success: return 200
        case .requiredAuth: return 401
        }
    }
}
