//
//  CalendarView.swift
//  GoldenCount
//
//  Created by Muugii M. on 1/31/25.
//

import SwiftUI
import CoreData

struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedDate = Date()
    
    @FetchRequest(
        entity: DailyCount.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \DailyCount.date, ascending: true)]
    ) private var  allCounts: FetchedResults<DailyCount>

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Date",
                           selection: $selectedDate,
                           displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                DailyCountView(date: selectedDate, counts: allCounts)
            }
            .navigationTitle("History")
        }
    }
}

struct DailyCountView: View {
    let date: Date
    let counts: FetchedResults<DailyCount>
    
    var dailyCount: Int32 {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!

        return counts.first(where: { count in
            let countDate = calendar.startOfDay(for: count.date ?? Date())
            return countDate >= startDate && countDate < endDate
        })?.count ?? 0
    }
    
    var body: some View {
        VStack {
            if dailyCount > 0 {
                Text("Goldens spotted: \(dailyCount)").font(.title2)
            } else {
                Text("No Goldies spotted this day").foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
