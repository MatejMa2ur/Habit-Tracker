//
//  Item.swift
//  habits
//
//  Created by Matej Mazur on 20/05/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
var name: String?
var timestamp: Date

    init(name: String, timestamp: Date) {
        self.name = name
        self.timestamp = timestamp
    }
}
