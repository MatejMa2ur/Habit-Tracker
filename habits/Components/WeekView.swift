//
//  WeekView.swift
//  habits
//
//  Created by Matej Mazur on 28/05/2024.
//

import SwiftUI

struct WeekView: View {
    var item: Habit
    
    init(item: Habit) {
        self.item = item
    }
    var body: some View {
        VStack(content: {
            HStack(content: {
                Text(Date().asReadableDay())
                    .bold()
            })
            HStack(content: {
                // Past
                getVStack(-3)
                getVStack(-2)
                getVStack(-1)

                // Today
                getVStack(0)

                // Future
                getVStack(1)
                getVStack(2)
                getVStack(3)
            })
        })
        .padding()
        
    }
    
    func getDate(_ dayOffset: Int) -> String {
        return Calendar.current.date(byAdding: .day, value: dayOffset, to: Date())!
            .getDayLetter()
    }
    
    func getVStack(_ dayOffset: Int) -> some View {
        return VStack(content: {
            if(dayOffset == 0){
                Text(getDate(dayOffset))
                .bold()
            }else{
                Text(getDate(dayOffset))
            }
            getRectangle(dayOffset)
        })
    }
    
    func getRectangle(_ dayOffset: Int) -> some View {
        let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date())!
        let eventCount = events(for: date).count
        
        return ZStack {
            let fillColor: Color = eventCount != 0 ? .blue : dayOffset <= 0 ? .white : .gray.opacity(0.2)
            let cornerRadius: CGFloat = dayOffset != 0 ? 6 : 10
            let size: CGFloat = dayOffset != 0 ? 25 : 40
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fillColor)
                .frame(width: size, height: size)
            
            if eventCount != 0 {
                RoundedRectangle(cornerRadius: cornerRadius * 0.7)
                    .fill(.white)
                    .frame(width: size * 0.8, height: size * 0.8)
                Text("\(eventCount)")
                    .foregroundStyle(.blue)
                    .bold()
            }
        }
    }
    
    func events(for date: Date) -> [Event] {
        let calendar = Calendar.current
        return item.events?.filter {
            calendar.isDate($0.timestamp, inSameDayAs: date)
        } ?? []
    }
}

#Preview {
    WeekView(item: Habit(name: "Sample habit"))
}
