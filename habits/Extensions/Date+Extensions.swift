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
}
