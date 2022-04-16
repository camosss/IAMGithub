//
//  SearchViewController.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/04/11.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties

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
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        tableView.register(RepositoryTableViewCell.self,
            forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
    }
}
