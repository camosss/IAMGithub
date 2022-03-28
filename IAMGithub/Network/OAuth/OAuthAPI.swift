//
//  OAuthAPI.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Moya

protocol OAuthAPIProtocol {
    func authorizeOnGithub()
    func populateAccesstoken(
        request: AccesstokenRequest,
        completion: @escaping (Result<AccesstokenResponse?, NetworkError>) -> Void
    )
}

final class OAuthAPI {
    let service: MoyaProvider<OAuthTarget>
    init() { service = MoyaProvider<OAuthTarget>() }
}

extension OAuthAPI: OAuthAPIProtocol {

    func authorizeOnGithub() {
        let client_id = Bundle.main.clientID
        let scope = "repo,user"

        let baseURL = "https://github.com/login/oauth/authorize?"
        let url = baseURL + "client_id=\(client_id)&scope=\(scope)"

        if let url = URL(string: url),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    func populateAccesstoken(
        request: AccesstokenRequest,
        completion: @escaping (Result<AccesstokenResponse?, NetworkError>) -> Void
    ) {
        service.request(.accesstoken(request)) { result in
            switch result {
            case .success(let response):
                let accesstokenResponse = try? response.map(AccesstokenResponse.self)
                completion(.success(accesstokenResponse))
            case .failure(let error):
                print("[populateAccesstoken] error", error)
                completion(.failure(
                    NetworkError(rawValue: error.response?.statusCode ?? -1) ?? .unknown)
                )
            }
        }
    }
}
