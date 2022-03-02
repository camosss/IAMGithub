//
//  ProfileViewController.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import UIKit

import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {

    // MARK: - Properties

    var viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()

    private var user: UserResponse?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        configureLeftBarButtonItem()
        populateUserData()
    }

    // MARK: - Helpers

    private func populateUserData() {
        viewModel
            .populateUserData(accessToken: Token.accessToken)
            .subscribe(onNext: { user in
                if let user = user {
                    self.user = user
                    self.configureRightBarButtonItem(Token.accessToken, user)
                } else {
                    self.view.makeToast("\(NetworkError.login)", position: .center)
                    self.configureRightBarButtonItem(Token.accessToken, nil)
                }
            })
            .disposed(by: disposeBag)
    }
}
