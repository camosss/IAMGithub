//
//  RepositoryTableViewCell.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/04.
//

import UIKit
import SnapKit

final class RepositoryTableViewCell: UITableViewCell {

    // MARK: - Properties

    let repoLabel = UILabel().then {
        $0.textColor = .repoTitle
        $0.font = .title
    }

    let repoDescriptionLabel = UILabel().then {
        $0.textColor = .basic
        $0.font = .body
        $0.numberOfLines = 0
    }

    let dateLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .subBody
    }

    lazy var stack = UIStackView(
        arrangedSubviews: [repoLabel, repoDescriptionLabel, dateLabel]
    ).then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    private func setUI() {
        addSubview(stack)
    }

    private func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    func updateUI(repo: UserReposResponse) {
        repoLabel.text = repo.name
        repoDescriptionLabel.text = repo.description
        dateLabel.text = repo.pushedAt
    }
}
