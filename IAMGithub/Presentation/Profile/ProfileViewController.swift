//
//  ProfileViewController.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import UIKit

import RxCocoa
import RxDataSources
import RxGesture
import RxSwift

final class ProfileViewController: UIViewController {

    // MARK: - Properties

    private var viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()

    private let headerView = ProfileHeaderView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ProfileSection.ProfileSectionModel>(
        configureCell: { [weak self] dataSource, tableView, indexPath, item in
            guard let self = self else { return UITableViewCell() }
            switch item {
            case .firstItem(let item):
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: RepositoryTableViewCell.reuseIdentifier
                ) as! RepositoryTableViewCell
                cell.selectionStyle = .none
                cell.updateUI(repo: item)
                
                cell.repoLabel
                    .rx.tapGesture()
                    .when(.recognized)
                    .throttle(.seconds(1), scheduler: MainScheduler.instance)
                    .subscribe(onNext: { _ in
                        let controller = DetailViewController(repo: item)
                        self.navigationController?.pushViewController(controller, animated: true)
                    })
                    .disposed(by: self.disposeBag)
                
                return cell
            }
        }
    )

    private let searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .background
        $0.backgroundColor = .basic
        $0.layer.cornerRadius = 64 / 2
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        configureLeftBarButtonItem()
        setUpTableView()
        setupSearchButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - Helpers

    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(RepositoryTableViewCell.self,
            forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
        tableView.register(ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ProfileHeaderView.reuseIdentifier)

        binding()
    }

    private func setupSearchButton() {
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(64)
        }
    }

    private func binding() {
        viewModel.viewController = self

        viewModel.user
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                self?.headerView.updateUI(user: user)
                self?.convertStarVC(user: user)
            })
            .disposed(by: disposeBag)

        viewModel.repos
            .asDriver()
            .map { value in
                return [ProfileSection.ProfileSectionModel(model: 0, items: value.map {
                    ProfileSection.RepoItems.firstItem($0)
                })]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.populateUserData(accessToken: Token.accessToken)
    }

    private func convertStarVC(user: UserResponse) {
        headerView.starredRepoButton
            .rx.tap
            .bind {
                let controller = StarViewController(user: user)
                self.navigationController?.pushViewController(controller, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return headerView
    }
}
