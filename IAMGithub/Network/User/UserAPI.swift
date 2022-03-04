//
//  UserAPI.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import RxSwift
import RxCocoa
import Moya

protocol UserAPIProtocol {
    func populateUserData(accessToken: String) -> Observable<UserResponse?>
    func populateUserRepos(user: UserResponse) -> Observable<[UserReposResponse]?>
}

class UserAPI: UserAPIProtocol {

    private let service = MoyaProvider<UserTarget>()

    func populateUserData(accessToken: String) -> Observable<UserResponse?> {
        return Observable.create { observer -> Disposable in
            self.service
                .request(.populateUserData(accessToken: accessToken)) { result in
                    switch result {
                    case .success(let response):
                        let userResponse = try? response.map(UserResponse.self)
                        observer.onNext(userResponse)
                    case .failure(let error):
                        print("[populateUserData] error", error)
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }

    func populateUserRepos(user: UserResponse) -> Observable<[UserReposResponse]?> {
        return Observable.create { observer in
            self.service
                .request(.populateUserRepos(user)) { result in
                    switch result {
                    case .success(let response):
                        let userRepos = try? response.map([UserReposResponse].self)
                        observer.onNext(userRepos)
                    case .failure(let error):
                        print("[populateUserRepos] error", error)
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
