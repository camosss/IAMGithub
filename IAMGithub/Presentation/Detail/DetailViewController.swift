//
//  DetailViewController.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/04/04.
//

import UIKit
import WebKit

import Then

final class DetailViewController: UIViewController {

    // MARK: - Properties

    private let repo: Repository?
    private let headerView = DetailHeaderView()
    private let webView = WKWebView().then {
        $0.allowsBackForwardNavigationGestures = true
    }

    // MARK: - Lifecycle

    init(repo: Repository) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setUI()
        setupConstraints()
        goDetailRepository()
    }

    // MARK: - Helpers

    private func setUI() {
        view.addSubview(headerView)
        view.addSubview(webView)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.height.equalTo(100).priority(750)
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        webView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
    }

    private func goDetailRepository() {
        if let repo = repo, let url = URL(string: repo.url) {
            let request = URLRequest(url: url)
            self.webView.load(request)
            self.headerView.updateUI(repo: repo)
        }
    }
}
