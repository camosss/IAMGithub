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
        view.backgroundColor = .background
        configureLeftBarButtonItem()
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
        viewModel.viewController = self

        viewModel.repos
            .asDriver()
            .drive(tableView.rx.items(
                cellIdentifier: RepositoryTableViewCell.reuseIdentifier,
                cellType: RepositoryTableViewCell.self
            )) { index, item, cell in
                cell.updateUI(repo: item)
            }
            .disposed(by: disposeBag)

        viewModel.populateUserData(accessToken: Token.accessToken)
    }
}
