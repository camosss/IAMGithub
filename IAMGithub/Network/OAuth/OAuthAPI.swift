//
//  OAuthAPI.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Moya

class OAuthAPI {

    static private let service = MoyaProvider<OAuthTarget>()

    static func authorizeOnGithub() {
        let client_id = Bundle.main.clientID
        let scope = "repo,user"

        let baseURL = "https://github.com/login/oauth/authorize?"
        let url = baseURL + "client_id=\(client_id)&scope=\(scope)"

        if let url = URL(string: url),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    static func populateAccesstoken(
        request: AccesstokenRequest,
        completion: @escaping (
            _ succeed: AccesstokenResponse?,
            _ failed: Error?,
            _ statusCode: Int?
        ) -> Void
    ) {
        service.request(.accesstoken(request)) { result in
            switch result {
            case .success(let response):
                let accesstokenResponse = try? response.map(AccesstokenResponse.self)
                completion(accesstokenResponse, nil, response.statusCode)
            case .failure(let error):
                print("[populateAccesstoken] error", error)
                completion(nil, error, error.response?.statusCode)
            }
        }
    }
}
