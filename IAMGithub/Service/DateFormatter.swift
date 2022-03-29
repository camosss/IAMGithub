//
//  DateFormatter.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/29.
//

import UIKit

extension String {
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)!
        return date
    }
}

extension Date {
    func getElapsedInterval() -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_kr")

        let interval = calendar.dateComponents([.year, .month, .day], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "Update \(year)" + " " + "year ago" :
                "Update \(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "Update \(month)" + " " + "month ago" :
                "Update \(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "Update \(day)" + " " + "day ago" :
                "Update \(day)" + " " + "days ago"
        } else {
            return "Update a moment ago"
        }
    }
}
