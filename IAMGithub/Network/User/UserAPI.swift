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
    func populateUserRepos(user: UserResponse) -> Observable<UserRepoResponse?>
    func populateStarredRepoData(user: UserResponse) -> Observable<UserStarredRepoResponse?>
}

final class UserAPI: UserAPIProtocol {
    let service: MoyaProvider<UserTarget>
    init() { service = MoyaProvider<UserTarget>() }
}

extension UserAPI {

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

    func populateUserRepos(user: UserResponse) -> Observable<UserRepoResponse?> {
        return Observable.create { observer -> Disposable in
            self.service
                .request(.populateUserRepos(user)) { result in
                    switch result {
                    case .success(let response):
                        let userRepos = try? response.map(UserRepoResponse.self)
                            .sorted(by: {
                                $0.pushedAt > $1.pushedAt
                            })
                        observer.onNext(userRepos)
                    case .failure(let error):
                        print("[populateUserRepos] error", error)
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }

    func populateStarredRepoData(user: UserResponse) -> Observable<UserStarredRepoResponse?> {
        return .create { observer -> Disposable in
            self.service
                .request(.populateStarredRepos(user)) { result in
                    switch result {
                    case .success(let response):
                        let starredRepoResponse = try? response.map(UserStarredRepoResponse.self)
                        observer.onNext(starredRepoResponse)
                    case .failure(let error):
                        print("[populateStarredRepoData] error", error)
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
