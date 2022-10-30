//
//  String+DateFormatter.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/30/22.
//

import Foundation

extension String {
    /// Returns a formatted date string from an ISO-8601 datetime string.
    /// - Parameter style: The date style to use when formatting the date.
    /// - Returns: A formatted date string, or `nil` if the string is not an ISO-8601 datetime string.
    func formatDateFromISO8601(style: DateFormatter.Style = .short, time: DateFormatter.Style = .none) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        guard let realDate = formatter.date(from: self) else {
            return nil
        }
        let realFormat = DateFormatter()
        realFormat.dateStyle = style
        realFormat.timeStyle = time
        return realFormat.string(from: realDate)
    }
}
