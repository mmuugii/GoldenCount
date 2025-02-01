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
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Date",
                           selection: $selectedDate,
                           displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                DailyCountView(date: selectedDate)
            }
            .navigationTitle("History")
        }
    }
}

struct DailyCountView: View {
    @State private var date: Date
    @FetchRequest var dailyCounts: FetchedResults<DailyCount>
    
    init(date: Date) {
        self._date = State(initialValue: date)
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        _dailyCounts = FetchRequest(
            entity: DailyCount.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \DailyCount.date, ascending: true)],
            predicate: NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        )
    }
    
    var body: some View {
        VStack {
            if let count = dailyCounts.first?.count {
                Text("Goldens spotted: \(count)").font(.title2)
            } else {
                Text("No Goldies spotted this day").foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
