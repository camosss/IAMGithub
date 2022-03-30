//
//  Double+Extenstion.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/30.
//

import UIKit

extension Double {
    var kmFormatted: String {
        if self >= 1000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current, self/1000)
                .replacingOccurrences(of: ".0", with: "")
        }

        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current, self/1000000)
                .replacingOccurrences(of: ".0", with: "")
        }

        return String(format: "%.0f", locale: Locale.current, self)
    }
}

