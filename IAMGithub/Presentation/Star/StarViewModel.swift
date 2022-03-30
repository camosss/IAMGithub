//
//  StarViewModel.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/30.
//

import Foundation

import RxSwift
import RxCocoa

class StarViewModel {

    var starredRepos = BehaviorRelay<UserStarredRepoResponse>(value: [])

    private let userAPI: UserAPIProtocol
    private let disposeBag = DisposeBag()

    init(userAPI: UserAPIProtocol = UserAPI()) {
        self.userAPI = userAPI
    }

    func populateStarredRepoData(user: UserResponse) {
        userAPI.populateStarredRepoData(user: user)
            .subscribe(onNext: { starredRepos in
                if let starredRepos = starredRepos {
                    self.starredRepos.accept(starredRepos)
                }
            })
            .disposed(by: disposeBag)
    }
}
