//
//  UIImageView+Extension.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import UIKit

import Kingfisher

extension UIImageView {
    func setImage(image: String) {
        self.kf.setImage(with: URL(string: image))
    }
}
