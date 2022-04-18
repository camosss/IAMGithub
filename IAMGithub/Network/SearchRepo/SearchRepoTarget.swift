//
//  SearchRepoTarget.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/04/18.
//

import Moya

enum SearchRepoTarget {
    case populateSearchRepoData(q: String, page: Int)
}

extension SearchRepoTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com/search/")!
    }

    var path: String {
        switch self {
        case .populateSearchRepoData:
            return "repositories"
        }
    }

    var method: Method {
        switch self {
        case .populateSearchRepoData: return .get
        }
    }

    var task: Task {
        switch self {
        case .populateSearchRepoData(let q, let page):
            return .requestParameters(
                parameters: [
                    "q": q,
                    "page": page
                ], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .populateSearchRepoData:
            return ["Accept": "application/vnd.github.v3+json"]
        }
    }
}
