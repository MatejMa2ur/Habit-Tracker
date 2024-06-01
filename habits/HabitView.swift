//
//  HabitView.swift
//  habits
//
//  Created by Matej Mazur on 21/05/2024.
//

import SwiftUI
import SwiftData

struct HabitView: View {
    @Environment(\.modelContext) private var modelContext
    
    var item: Habit
    
    init(item: Habit) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                if geometry.size.width > 700 {
                    
                    YearView(item: item)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else if geometry.size.width > 400{
                    
                    MonthView(item: item)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                } else {
                    WeekView(item: item)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                }
            }
            List {
                Section(header: Text("Dates")) {
                    if let events = item.events {
                        ForEach(events) { event in
                            HStack {
                                Text(event.timestamp, style: .date)
                                Text(event.timestamp, style: .time)
                            }
                            .contextMenu {
                                Button(action: {
                                    self.deleteItems(event: event)
                                }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                }
            }
        }

    .navigationTitle(item.name)
    .toolbar {
        ToolbarItemGroup {
            Button {
                withAnimation {
                    let newEvent = Event(timestamp: Date())
                    item.events?.append(newEvent)
                }
            } label: {
                Label("Add New Task", systemImage: "plus")
            }
        }
    }
    }
    
    
    private func deleteItems(event: Event) {
        withAnimation {
            if let events = item.events{
                if let index = events.firstIndex(of: event) {
                    item.events?.remove(at: index)
                    modelContext.delete(event)
                }
            }
        }
    }
}

