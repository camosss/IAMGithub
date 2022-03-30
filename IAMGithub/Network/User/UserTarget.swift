//
//  UserTarget.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Moya

enum UserTarget {
    case populateUserData(accessToken: String)
    case populateUserRepos(UserResponse)
    case populateStarredRepos(UserResponse)
}

extension UserTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }

    var path: String {
        switch self {
        case .populateUserData:
            return "user"
        case .populateUserRepos(let user):
            return "users/\(user.username)/repos"
        case .populateStarredRepos(user: let user):
            return "users/\(user.username)/starred"
        }
    }

    var method: Method {
        switch self {
        case .populateUserData,
                .populateUserRepos,
                .populateStarredRepos:
            return .get
        }
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        switch self {
        case .populateUserData(let accessToken):
            return ["Authorization": "token \(accessToken)"]
        case .populateUserRepos(_),
                .populateStarredRepos:
            return nil
        }
    }
}
