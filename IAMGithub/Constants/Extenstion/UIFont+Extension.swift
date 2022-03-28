//
//  UIFont+Extension.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/28.
//

import UIKit.UIFont

extension UIFont {
    static var navigationTitle: UIFont {
        return UIFont.boldSystemFont(ofSize: 24)
    }
    static var title: UIFont {
        return UIFont.boldSystemFont(ofSize: 17)
    }
    static var subtitle: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    static var body: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    static var subBody: UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
}
