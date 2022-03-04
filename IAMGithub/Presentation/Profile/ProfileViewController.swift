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

    let tableView = UITableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        configureLeftBarButtonItem()
        populateUserData()
        setUpTableView()
    }

    // MARK: - Helpers

    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.register(
            RepositoryTableViewCell.self,
            forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier
        )

        binding()
    }

    private func binding() {
        viewModel.repos
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: RepositoryTableViewCell.reuseIdentifier,
                cellType: RepositoryTableViewCell.self
            )) { index, item, cell in
                cell.updateUI(repo: item)
            }
            .disposed(by: disposeBag)
    }

    private func populateUserData() {
        viewModel
            .populateUserData(accessToken: Token.accessToken)
            .subscribe(onNext: { user in
                if let user = user {
                    self.viewModel.user = user
                    self.configureRightBarButtonItem(Token.accessToken, user)
                    self.populateUserRepos(user: user)
                } else {
                    self.view.makeToast("\(NetworkError.login)", position: .center)
                    self.configureRightBarButtonItem(Token.accessToken, nil)
                }
            })
            .disposed(by: disposeBag)
    }

    private func populateUserRepos(user: UserResponse) {
        viewModel
            .populateUserRepos(user: user)
            .subscribe(onNext: { repos in
                if let repos = repos {
                    self.viewModel.repos.onNext(repos)
                }
            })
            .disposed(by: disposeBag)
    }
}
