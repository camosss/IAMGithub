//
//  RepositoryTableViewCell.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/04.
//

import UIKit
import SnapKit

class RepositoryTableViewCell: UITableViewCell {

    // MARK: - Properties

    let repoLabel = UILabel().then {
        $0.textColor = Color.repoTitle
        $0.font = Font.title
    }

    let repoDescriptionLabel = UILabel().then {
        $0.textColor = Color.basic
        $0.font = Font.body
        $0.numberOfLines = 0
    }

    let dateLabel = UILabel().then {
        $0.textColor = Color.gray
        $0.font = Font.subBody
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
