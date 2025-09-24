//
//  Utilities.swift
//  assignment1
//
//  Created by Bishal Paudel on 9/24/25.
//

import Foundation

// MARK: - Format Date Range
func formattedDateRange(start: Date, end: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return "\(formatter.string(from: start)) → \(formatter.string(from: end))"
}

// MARK: - Duration Calculator
func tripLength(from start: Date, to end: Date) -> Int {
    let calendar = Calendar.current
    let startDay = calendar.startOfDay(for: start)
    let endDay = calendar.startOfDay(for: end)
    let components = calendar.dateComponents([.day], from: startDay, to: endDay)
    return (components.day ?? 0) + 1
}
