//
//  HabitViewEditName.swift
//  habits
//
//  Created by Matej Mazur on 21/05/2024.
//

import SwiftUI

struct HabitViewEditName: View {
    var item: Habit

    @State private var debouncedText: String = ""
    @State private var text: String = ""
    @State private var timer: Timer? = nil
    
    var body: some View {
        TextField("Enter name", text: $debouncedText, onCommit:  {
            self.item.name = self.debouncedText
        })
        .onAppear {
            self.debouncedText = self.item.name
            self.text = self.item.name
        }
        .onChange(of:debouncedText) {oldValue, newValue in
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
                self.text = newValue
                self.item.name = newValue
            }
        }
    }
}
