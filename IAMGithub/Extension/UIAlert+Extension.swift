//
//  UIAlert+Extension.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import UIKit

final class AlertHelper {
    static func actionSheetAlert(
        title: String,
        completion: @escaping () -> (),
        over viewController: UIViewController
    ) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: title, style: .destructive) { _ in
            completion()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(logout)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
    }
}
