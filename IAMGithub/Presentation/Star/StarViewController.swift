//
//  StarViewController.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/30.
//

import UIKit

import RxCocoa
import RxSwift

final class StarViewController: UIViewController {

    // MARK: - Properties

    private var viewModel = StarViewModel()
    private let disposeBag = DisposeBag()
    private var user: UserResponse?

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - Lifecycle

    init(user: UserResponse) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setUpTableView()
    }

    // MARK: - Heplers

    private func setLargeTitle(user: UserResponse) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "\(user.username)'s Stars"
    }

    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.contentInset.top = 24

        tableView.register(StarredRepositoryTableViewCell.self,
            forCellReuseIdentifier: StarredRepositoryTableViewCell.reuseIdentifier)

        binding()
    }

    private func binding() {
        viewModel.starredRepos
            .asDriver()
            .drive(tableView.rx.items(
                cellIdentifier: StarredRepositoryTableViewCell.reuseIdentifier,
                cellType: StarredRepositoryTableViewCell.self
            )) { (indexPath, item, cell) in
                cell.selectionStyle = .none
                cell.updateUI(repo: item)
            }
            .disposed(by: disposeBag)

        if let user = user {
            viewModel.populateStarredRepoData(user: user)

            setLargeTitle(user: user)
            configureRightBarButtonItem(Token.accessToken, user)
        }
    }
}
