//
//  YearView.swift
//  habits
//
//  Created by Matej Mazur on 31/05/2024.
//

import SwiftUI

struct YearView: View {
    var item: Habit
    
    init(item: Habit) {
        self.item = item
    }
    
    var body: some View {
        // TODO: add year view
        MonthView(item: item)
    }
}

#Preview {
    YearView(item: Habit(name: "Sample habit"))
}
