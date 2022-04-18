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
        tableView.contentInset.top = 16
        tableView.keyboardDismissMode = .onDrag

        view.addSubview(tableView)
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

        searchBar
            .rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { text in
                self.viewModel.populateSearchRepoData(with: text, page: 1)
                self.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}

