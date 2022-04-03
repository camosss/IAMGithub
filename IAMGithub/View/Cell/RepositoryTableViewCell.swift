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

    let repoLabel = DefaultLabel(font: .title, textColor: .repoTitle)
    private let repoDescriptionLabel = DefaultLabel(font: .body, textColor: .basic, numberOfLines: 0)
    private let dateLabel = DefaultLabel(font: .subBody, textColor: .gray)

    // MARK: - UIStackView

    lazy var labelStack = UIStackView(
        arrangedSubviews: [repoDescriptionLabel, dateLabel]
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
        contentView.addSubview(repoLabel)
        contentView.addSubview(labelStack)
    }

    private func setupConstraints() {
        repoLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(16)
        }

        labelStack.snp.makeConstraints { make in
            make.top.equalTo(repoLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    func updateUI(repo: Repository) {
        repoLabel.text = repo.name
        repoDescriptionLabel.text = repo.description
        dateLabel.text = repo.pushedAt.toDate.getElapsedInterval()
    }
}
