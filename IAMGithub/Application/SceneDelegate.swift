//
//  SceneDelegate.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import UIKit

import KeychainSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(
            rootViewController: ProfileViewController()
        )
        window?.makeKeyAndVisible()
    }

    func scene(
        _ scene: UIScene,
        openURLContexts URLContexts: Set<UIOpenURLContext>
    ) {
        if let url = URLContexts.first?.url {
            if url.absoluteString.starts(with: "iamgithub://login") {
                if let code = url.absoluteString
                    .split(separator: "=")
                    .last.map({ String($0) }) {

                    let request = AccesstokenRequest(
                        client_id: Bundle.main.clientID,
                        client_secret: Bundle.main.clientSecrets,
                        code: code
                    )

                    OAuthAPI().populateAccesstoken(request: request) { response in
                        switch response {
                        case .success(let response):
                            let accessToken = response?.accessToken ?? ""
                            KeychainSwift().set(
                                accessToken,
                                forKey: keyEnum.accessToken.rawValue
                            )

                            Helper.convertRootViewController(scene)
                        case .failure(let error):
                            print(error)
                            Helper.convertRootViewController(scene)
                        }
                    }
                }
            }
        }
    }
}

