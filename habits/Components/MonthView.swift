//
//  MonthView.swift
//  habits
//
//  Created by Matej Mazur on 31/05/2024.
//

import SwiftUI

struct ColumnInfo {
    let dayOfWeekIndex: Int
    var daysOfMonth: [DayInfo] = []
}
struct DayInfo {
    let date: Date
}

struct MonthView: View {
    var item: Habit
    
    init(item: Habit) {
        self.item = item
    }
    @State private var monthArray: [ColumnInfo] = []
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]  // customize according to your locale's week start
    
    var body: some View {
        VStack {
            HStack {
                ForEach(monthArray, id: \.dayOfWeekIndex) { columnInfo in
                    VStack {
                        Text(daysOfWeek[columnInfo.dayOfWeekIndex])
                        ForEach(columnInfo.daysOfMonth, id: \.date) { dayInfo in
                            getRectangle(dayInfo)
                        }
                    }
                }
            }
        }
        .onAppear {
            monthArray = createMonthArray()
        }
    }
    
    func createMonthArray() -> [ColumnInfo] {
        var dayInfos: [ColumnInfo] = []
        for i in 0..<7 {
            dayInfos.append(ColumnInfo(dayOfWeekIndex: i, daysOfMonth: []))
        }

        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())!
        let startOfWeek = calendar.component(.weekday, from: Date())
        
        for i in 1..<startOfWeek {
            let date = Calendar.current.date(byAdding: .day, value: i-startOfWeek, to: Date())!
            
            dayInfos[i-1].daysOfMonth.append(DayInfo(date: date))
        }
        
        for day in range {
            if let date = calendar.date(from: DateComponents(year: calendar.component(.year, from: Date()), month: calendar.component(.month, from: Date()), day: day)) {
                let weekday = calendar.component(.weekday, from: date)
                dayInfos[weekday-1].daysOfMonth.append(DayInfo(date: date))
            }
        }
        
        let components = calendar.dateComponents([.year, .month], from: Date())
        if var lastDayOfMonth = calendar.date(from: components), let nextMonth = calendar.date(byAdding: .month, value: 1, to: lastDayOfMonth) {
            lastDayOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth)!
            let endOfWeek = calendar.component(.weekday, from: lastDayOfMonth)
            for i in endOfWeek..<7 {
                let date = Calendar.current.date(byAdding: .day, value: i, to: lastDayOfMonth)!
                
                dayInfos[i].daysOfMonth.append(DayInfo(date: date))
            }
        }
        
        return dayInfos
    }
    
    func getRectangle(_ dayInfo: DayInfo) -> some View {
        let eventCount = events(for: dayInfo.date).count
        
        return ZStack {
            let fillColor: Color = eventCount != 0 ? 
                .blue 
                : dayInfo.date >= Date().startOfMonth()! && dayInfo.date <= Date().endOfMonth()! ?
                    dayInfo.date > Date() ?
                        .white.opacity(0.5) 
                        : .white
                    : .gray.opacity(0.2)
            let cornerRadius: CGFloat = 6
            let size: CGFloat = 25
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fillColor)
                .frame(width: size, height: size)
            
            if eventCount != 0 {
                RoundedRectangle(cornerRadius: cornerRadius * 0.7)
                    .fill(Color.background)
                    .frame(width: size * 0.8, height: size * 0.8)
                RoundedRectangle(cornerRadius: cornerRadius * 0.7)
                    .fill(dayInfo.date >= Date().startOfMonth()! ? .white : .gray.opacity(0.2))
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

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(item: Habit(name: "Sample habit"))
    }
}
