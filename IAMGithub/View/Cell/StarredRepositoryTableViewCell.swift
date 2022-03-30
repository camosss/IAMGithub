//
//  StarredRepositoryTableViewCell.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/30.
//

import UIKit

final class StarredRepositoryTableViewCell: UITableViewCell {

    // MARK: - Properties

    private lazy var profileImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 50 / 2
        $0.isUserInteractionEnabled = true
    }

    let starButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.tintColor = .star
    }

    private let repoLabel = DefaultLabel(font: .title, textColor: .repoTitle)
    private let repoDescriptionLabel = DefaultLabel(font: .body, textColor: .basic, numberOfLines: 0)
    private let dateLabel = DefaultLabel(font: .subBody, textColor: .gray)
    private let starCountLabel = DefaultLabel(font: .body, textColor: .label)

    // MARK: - UIStackView

    lazy var labelStack = UIStackView(
        arrangedSubviews: [repoLabel, repoDescriptionLabel, dateLabel]
    ).then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    lazy var starStack = UIStackView(
        arrangedSubviews: [starButton, starCountLabel]
    ).then {
        $0.axis = .vertical
        $0.spacing = 3
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
        addSubview(profileImageView)
        addSubview(labelStack)
        addSubview(starStack)
    }

    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
            make.width.height.equalTo(50)
        }

        labelStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }

        starStack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(repoDescriptionLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(50)
        }
    }

    func updateUI(repo: Repository) {
        profileImageView.setImage(image: repo.owner.avatarURL)
        repoLabel.text = repo.name
        repoDescriptionLabel.text = repo.itemDescription
        dateLabel.text = repo.pushedAt.toDate.getElapsedInterval()
        starCountLabel.text = "\(Double(repo.stargazersCount).kmFormatted)"
        starCountLabel.textAlignment = .center
    }
}
