//
//  Date+Extensions.swift
//  habits
//
//  Created by Matej Mazur on 22/05/2024.
//

import Foundation

extension Date {
    func asYearMonthDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func asReadableDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter.string(from: self)
    }
    
    func getDayLetter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return String(dateFormatter.string(from: self).prefix(1))
    }
    
    func startOfMonth() -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)
    }

    func endOfMonth() -> Date? {
        let calendar = Calendar.current
        if let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) {
            return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)
        }
        return nil
    }
}
