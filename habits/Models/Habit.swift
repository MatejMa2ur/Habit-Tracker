//
//  Habit.swift
//  habits
//
//  Created by Matej Mazur on 22/05/2024.
//

import Foundation
import SwiftData

@Model
final class Habit {
    var id: UUID
    var name: String
    var timestamp: Date
    var events: [Event]? = nil
    
    init(name: String, timestamp: Date = Date()) {
        self.id = UUID()
        self.name = name
        self.timestamp = timestamp
    }
}
