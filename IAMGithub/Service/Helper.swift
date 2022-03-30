//
//  Helper.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import UIKit

final class Helper {
    static func convertRootViewController(_ scene: UIScene?) {
        DispatchQueue.main.async {
            if let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sceneDelegate.window?.rootViewController = UINavigationController(
                    rootViewController: ProfileViewController()
                )
            }
        }
    }
}
