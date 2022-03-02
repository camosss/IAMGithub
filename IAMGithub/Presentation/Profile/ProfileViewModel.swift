//
//  ProfileViewModel.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

import RxSwift
import RxCocoa

class ProfileViewModel {

    private let userAPI: UserAPIProtocol

    init(userAPI: UserAPIProtocol = UserAPI()) {
        self.userAPI = userAPI
    }

    func populateUserData(accessToken: String) -> Observable<UserResponse?> {
        userAPI.populateUserData(accessToken: accessToken)
    }
}
