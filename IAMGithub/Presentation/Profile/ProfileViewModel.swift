//
//  ProfileViewModel.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

import RxSwift
import RxCocoa

final class ProfileViewModel {

    weak var viewController: ProfileViewController?

    var user = PublishRelay<UserResponse>()
    var repos = BehaviorRelay<[UserReposResponse]>(value: [])

    private let userAPI: UserAPIProtocol
    private let disposeBag = DisposeBag()

    init(userAPI: UserAPIProtocol = UserAPI()) {
        self.userAPI = userAPI
    }

    func populateUserData(accessToken: String) {
        userAPI.populateUserData(accessToken: accessToken)
            .subscribe(onNext: { user in
                if let user = user {
                    self.user.accept(user)
                    self.populateUserRepos(user: user)
                    self.viewController?.configureRightBarButtonItem(Token.accessToken, user)
                } else {
                    self.viewController?.configureRightBarButtonItem(Token.accessToken, nil)
                }
            })
            .disposed(by: disposeBag)
    }

    private func populateUserRepos(user: UserResponse) {
        userAPI.populateUserRepos(user: user)
            .subscribe(onNext: { repos in
                if let repos = repos {
                    self.repos.accept(repos)
                }
            })
            .disposed(by: disposeBag)
    }
}
