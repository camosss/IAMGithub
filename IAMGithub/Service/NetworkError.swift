//
//  NetworkError.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

enum NetworkError: Int, Error {
    case duplicatedError = 201
    case notFoundError = 404
    case unregisterUser = 406
    case internalServerError = 500
    case internalClientError = 501
    case unknown

    var description: String { self.errorDescription }
}

extension NetworkError {
    var errorDescription: String {
        switch self {
        case .duplicatedError: return "201:DUPLICATE_ERROR"
        case .notFoundError: return "404:NOT_FOUND_ERROR"
        case .unregisterUser: return "406:UNREGISTER_USER_ERROR"
        case .internalServerError: return "500:INTERNAL_SERVER_ERROR"
        case .internalClientError: return "501:INTERNAL_CLIENT_ERROR"
        default: return "UN_KNOWN_ERROR"
        }
    }
}
