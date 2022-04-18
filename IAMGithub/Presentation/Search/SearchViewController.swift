//
//  SearchViewController.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/04/11.
//

import UIKit

import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {

    // MARK: - Properties

    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()

    private let tableView = UITableView()
    private let searchBar = UISearchBar()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondBackground
        setSearchBar()
        setUpTableView()
    }

    // MARK: - Helpers

    private func setSearchBar() {
        searchBar.placeholder = "Search Repositories..."
        self.navigationItem.titleView = searchBar
    }

    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.contentInset.top = 16
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.register(RepositoryTableViewCell.self,
            forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)

        binding()
    }

    private func binding() {
        viewModel.repos
            .asDriver()
            .drive(tableView.rx.items(
                cellIdentifier: RepositoryTableViewCell.reuseIdentifier,
                cellType: RepositoryTableViewCell.self)
            ) { index, item, cell in
                cell.updateUI(repo: item)
                cell.pushDetailVC(vc: self, item: item)
            }
            .disposed(by: disposeBag)

        /// searchBar 연결
        viewModel.populateSearchRepoData(with: "Rx", page: 1)
    }
}
