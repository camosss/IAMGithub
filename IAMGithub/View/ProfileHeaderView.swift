//
//  ProfileHeaderView.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/28.
//

import UIKit

final class ProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties

    private lazy var profileImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 70 / 2
        $0.isUserInteractionEnabled = true
    }

    private let nameLabel = DefaultLabel(font: .navigationTitle, textColor: .label)
    private let usernameLabel = DefaultLabel(font: .title, textColor: .label)
    private let bioLabel = DefaultLabel(font: .body, textColor: .gray, numberOfLines: 0)

    private let followerCountLabel = DefaultLabel(font: .subtitle, textColor: .label)
    private let followingCountLabel = DefaultLabel(font: .subtitle, textColor: .label)
    private let followerLabel = DefaultLabel(font: .body, textColor: .gray)
    private let followingLabel = DefaultLabel(font: .body, textColor: .gray)

    let starredRepoButton = UIButton().then {
        $0.titleLabel?.font = .body
        $0.setTitleColor(.background, for: .normal)
        $0.layer.cornerRadius = 8
    }

    // MARK: - UIStackView

    lazy var infoStack = UIStackView(
        arrangedSubviews: [nameLabel, usernameLabel, bioLabel]
    ).then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    lazy var followerStack = UIStackView(
        arrangedSubviews: [followerCountLabel,followerLabel]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 3
    }

    lazy var followingStack = UIStackView(
        arrangedSubviews: [followingCountLabel, followingLabel]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 3
    }

    lazy var followStack = UIStackView(
        arrangedSubviews: [followerStack, followingStack]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 5
    }

    // MARK: - Lifecycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("ProfileHeaderView: fatal error")
    }

    // MARK: - Helpers

    private func setView() {
        addSubview(profileImageView)
        addSubview(infoStack)
        addSubview(followStack)
        addSubview(starredRepoButton)
    }

    private func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.leading.equalTo(16)
            make.width.height.equalTo(70)
        }

        infoStack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }

        followStack.snp.makeConstraints { make in
            make.top.equalTo(infoStack.snp.bottom).offset(24)
            make.leading.equalTo(profileImageView)
            make.bottom.equalToSuperview().inset(24)
        }

        starredRepoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(followStack).offset(8)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
    }

    func updateUI(user: UserResponse) {
        profileImageView.setImage(image: user.avatarURL)
        nameLabel.text = user.name
        usernameLabel.text = user.username
        bioLabel.text = user.bio

        starredRepoButton.setTitle("★ Starred", for: .normal)
        starredRepoButton.backgroundColor = .label

        followerLabel.text = "follower"
        followingLabel.text = "following"
        followerCountLabel.text = "\(user.followers)"
        followingCountLabel.text = "\(user.following)"
    }
}
