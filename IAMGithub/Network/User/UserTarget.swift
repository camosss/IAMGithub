//
//  UserTarget.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Moya

enum UserTarget {
    case populateUserData(accessToken: String)
}

extension UserTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }

    var path: String {
        switch self {
        case .populateUserData:
            return "user"
        }
    }

    var method: Method {
        switch self {
        case .populateUserData: return .get
        }
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        switch self {
        case .populateUserData(let accessToken):
            return ["Authorization": "token \(accessToken)"]
        }
    }
}
