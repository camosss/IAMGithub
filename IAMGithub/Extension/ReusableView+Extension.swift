//
//  ReusableView+Extension.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/04.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
