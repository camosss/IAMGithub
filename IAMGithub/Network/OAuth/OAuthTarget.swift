//
//  OAuthTarget.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Moya

enum OAuthTarget {
    case accesstoken(AccesstokenRequest)
}

extension OAuthTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://github.com/login/oauth/")!
    }

    var path: String {
        switch self {
        case .accesstoken:
            return "access_token"
        }
    }

    var method: Method {
        switch self {
        case .accesstoken: return .post
        }
    }

    var task: Task {
        switch self {
        case .accesstoken(let request):
            return .requestParameters(
                parameters: ["client_id": request.client_id,
                             "client_secret": request.client_secret,
                             "code": request.code],
                encoding: URLEncoding.default
            )
        }
    }

    var headers: [String : String]? {
        switch self {
        case .accesstoken:
            return ["Accept": "application/json"]
        }
    }
}
