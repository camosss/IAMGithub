//
//  ProfileHeaderView.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/28.
//

import UIKit

final class ProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties

    lazy var profileImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 70 / 2
        $0.isUserInteractionEnabled = true
    }

    let nameLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .navigationTitle
    }

    let usernameLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .subtitle
    }

    let bioLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .body
        $0.numberOfLines = 0
    }

    lazy var infoStack = UIStackView(
        arrangedSubviews: [
            nameLabel,
            usernameLabel,
            bioLabel
        ]).then {
            $0.axis = .vertical
            $0.spacing = 8
        }

    let followerCountLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .subtitle
    }

    let followerLabel = UILabel().then {
        $0.text = "follower"
        $0.textColor = .gray
        $0.font = .body
    }

    lazy var followerStack = UIStackView(
        arrangedSubviews: [
            followerCountLabel,
            followerLabel
        ]).then {
            $0.axis = .horizontal
            $0.spacing = 3
        }

    let followingCountLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .subtitle
    }

    let followingLabel = UILabel().then {
        $0.text = "following"
        $0.textColor = .gray
        $0.font = .body
    }
    
    lazy var followingStack = UIStackView(
        arrangedSubviews: [
            followingCountLabel,
            followingLabel
        ]).then {
            $0.axis = .horizontal
            $0.spacing = 3
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
        addSubview(followerStack)
        addSubview(followingStack)
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

        followerStack.snp.makeConstraints { make in
            make.top.equalTo(infoStack.snp.bottom).offset(16)
            make.leading.equalTo(profileImageView)
        }

        followingStack.snp.makeConstraints { make in
            make.top.equalTo(followerStack)
            make.leading.equalTo(followerStack.snp.trailing).offset(8)
        }
    }
    
    func updateUI(user: UserResponse) {
        profileImageView.setImage(image: user.avatarURL)
        nameLabel.text = user.name
        usernameLabel.text = user.username
        bioLabel.text = user.bio

        followerCountLabel.text = "\(user.followers)"
        followingCountLabel.text = "\(user.following)"
    }
}
