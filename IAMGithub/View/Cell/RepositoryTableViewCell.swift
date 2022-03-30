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

    private let repoLabel = DefaultLabel(font: .title, textColor: .repoTitle)
    private let repoDescriptionLabel = DefaultLabel(font: .body, textColor: .basic, numberOfLines: 0)
    private let dateLabel = DefaultLabel(font: .subBody, textColor: .gray)

    // MARK: - UIStackView

    lazy var labelStack = UIStackView(
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
        addSubview(labelStack)
    }

    private func setupConstraints() {
        labelStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    func updateUI(repo: UserReposResponse) {
        repoLabel.text = repo.name
        repoDescriptionLabel.text = repo.description
        dateLabel.text = repo.pushedAt.toDate.getElapsedInterval()
    }
}
