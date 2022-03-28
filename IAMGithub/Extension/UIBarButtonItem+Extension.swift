//
//  UIBarButtonItem+Extension.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import UIKit

import Then
import Toast_Swift
import KeychainSwift

extension UIViewController {
    func configureLeftBarButtonItem() {
        let label = UILabel().then {
            $0.text = "Github"
            $0.textColor = UIColor.label
            $0.font = .navigationTitle
        }

        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    func configureRightBarButtonItem(_ isAccessToken: String, _ user: UserResponse?) {
        let profileImageView = UIImageView().then {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 32 / 2
            $0.widthAnchor.constraint(equalToConstant: 32).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
            $0.setImage(image: user?.avatarURL ?? "")
            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(rightBarButtonItemDidTap)
            )
            $0.addGestureRecognizer(tapGesture)
        }

        let loginButton = UIButton().then {
            $0.setTitle("Login", for: .normal)
            $0.setTitleColor(.label, for: .normal)
            $0.addTarget(
                self,
                action: #selector(rightBarButtonItemDidTap),
                for: .touchUpInside
            )
        }

        self.navigationItem.rightBarButtonItem = isAccessToken.isEmpty ?
        UIBarButtonItem.init(customView: loginButton) :
        UIBarButtonItem.init(customView: profileImageView)
    }

    @objc func rightBarButtonItemDidTap() {
        let accessToken = Token.accessToken
        let scene = UIApplication.shared.connectedScenes.first

        if accessToken.isEmpty {
            OAuthAPI().authorizeOnGithub()
        } else {
            AlertHelper.actionSheetAlert(title: "Logout", completion: {
                KeychainSwift().delete(keyEnum.accessToken.rawValue)

                DispatchQueue.main.async {
                    self.view.makeToast("로그아웃이 완료되었습니다.", position: .center)
                    Helper.convertRootViewController(scene)
                }
            }, over: self)
        }
    }
}
