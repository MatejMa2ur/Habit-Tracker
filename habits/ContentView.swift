//
//  ContentView.swift
//  habits
//
//  Created by Matej Mazur on 20/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Habit]

    var body: some View {
        NavigationSplitView {
            VStack {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            HabitView(item: item)
                        } label: {
                            HabitViewEditName(item: item)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
                .safeAreaInset(edge: .bottom) {
                    Button(action: { addItem() }, label: {
                        Label("Add Group", systemImage: "plus.circle")
                    })
                    .buttonStyle(.borderless)
                    .foregroundColor(.accentColor)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .keyboardShortcut(/*@START_MENU_TOKEN@*/KeyEquivalent("a")/*@END_MENU_TOKEN@*/, modifiers: /*@START_MENU_TOKEN@*/.command/*@END_MENU_TOKEN@*/)
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Habit(name: "New Habit", timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func updateName(item: Habit, newValue: String) {
        withAnimation {
            item.name = newValue
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}
