//
//  Event.swift
//  habits
//
//  Created by Matej Mazur on 22/05/2024.
//

import Foundation
import SwiftData

@Model
final class Event {
    var id: UUID
    var timestamp: Date
  
    init(timestamp: Date) {
        self.id = UUID()
        self.timestamp = timestamp
    }
}
