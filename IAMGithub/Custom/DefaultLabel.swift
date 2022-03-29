//
//  DefaultLabel.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/29.
//

import UIKit.UILabel

final class DefaultLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(font: UIFont, textColor: UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor
    }

    convenience init(font: UIFont, textColor: UIColor, numberOfLines: Int) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}
