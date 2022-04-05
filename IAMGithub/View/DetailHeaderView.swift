//
//  DetailHeaderView.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/04/04.
//

import UIKit

final class DetailHeaderView: UIView {

    // MARK: - Properties

    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.image = UIImage()
    }

    private let starButton = UIButton().then {
        let starImage = UIImage(systemName: "star")
        let selectedStarImage = UIImage(systemName: "star.fill")
        $0.setImage(starImage, for: .normal)
        $0.setImage(selectedStarImage, for: .selected)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .star
    }

    private let repoLabel = DefaultLabel(font: .title, textColor: .label)
    private let ownerLabel = DefaultLabel(font: .subtitle, textColor: .gray)
    private let starCountLabel = DefaultLabel(font: .body, textColor: .label)

    // MARK: - UIStackView

    private lazy var nameStackView = UIStackView(
        arrangedSubviews: [repoLabel, ownerLabel]
    ).then {
        $0.axis = .vertical
    }

    private lazy var starStackView = UIStackView(
        arrangedSubviews: [starButton, starCountLabel]
    ).then {
        $0.axis = .vertical
    }

    private lazy var infoStackView = UIStackView(
        arrangedSubviews: [profileImageView, nameStackView, starStackView]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Helpers
    
    private func setView() {
        addSubview(infoStackView)
    }

    private func setConstraints() {
        ownerLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        starCountLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)

        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        starButton.snp.makeConstraints {
            $0.width.equalTo(40)
        }

        infoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    func updateUI(repo: Repository) {
        profileImageView.setImage(image: repo.owner.avatarURL)
        repoLabel.text = repo.name
        ownerLabel.text = repo.owner.login
        starCountLabel.text = "\(Double(repo.stargazersCount).kmFormatted)"
        starCountLabel.textAlignment = .center
    }
}
