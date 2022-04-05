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

    private let starImageView = UIImageView(image: UIImage(systemName: "star"))
    private let starCountLabel = DefaultLabel(font: .body, textColor: .gray)
    private let forkImageView = UIImageView(image: UIImage(systemName: "scale.3d"))
    private let forkCountLabel = DefaultLabel(font: .body, textColor: .gray)

    // MARK: - UIStackView
    
    private lazy var starStackView = UIStackView(
        arrangedSubviews: [starImageView, starCountLabel]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 3
    }

    private lazy var forkStackView = UIStackView(
        arrangedSubviews: [forkImageView, forkCountLabel]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 3
    }

    private lazy var bottomStackView = UIStackView(
        arrangedSubviews: [starStackView, forkStackView, dateLabel]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 16
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConfiguration()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    private func setUI() {
        contentView.addSubview(repoLabel)
        contentView.addSubview(repoDescriptionLabel)
        contentView.addSubview(bottomStackView)
    }

    private func setConfiguration() {
        starImageView.tintColor = .gray
        forkImageView.tintColor = .gray
    }

    private func setupConstraints() {
        repoLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(16)
        }

        repoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(repoLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(repoDescriptionLabel.snp.bottom).offset(12)
            make.leading.bottom.equalToSuperview().inset(16)
        }
    }

    func updateUI(repo: Repository) {
        repoLabel.text = repo.name
        repoDescriptionLabel.text = repo.description
        dateLabel.text = repo.pushedAt.toDate.getElapsedInterval()

        starStackView.isHidden = repo.stargazersCount == 0 ? true : false
        forkStackView.isHidden = repo.forksCount == 0 ? true : false
        starCountLabel.text = "\(repo.stargazersCount)"
        forkCountLabel.text = "\(repo.forksCount)"
    }
}
