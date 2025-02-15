//
//  CounterView.swift
//  GoldenCount
//
//  Created by Muugii M. on 1/31/25.
//

import SwiftUI
import CoreData
import UIKit

struct CounterView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @ObservedObject private var goldenCount = GoldenCount.shared
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Today's Golden Count")
        .font(.title2)
      Text("\(goldenCount.count)")
        .font(.system(size: 72, weight: .bold))
      Button(action: incrementCount) {
        HStack {
          Image(systemName: "pawprint.fill")
          Text("Spotted a Golden!")
        }
        .padding()
        .background(Color.orange)
        .foregroundColor(.white)
        .cornerRadius(10)
      }
      
      if goldenCount.count > 0 {
        Button(action: decrementCount) {
          Text("Oops! Remove one")
            .foregroundColor(.orange)
        }
      }
    }
    .padding()
    .onAppear(perform: loadTodayCount)
  }
  
  private func incrementCount() {
    goldenCount.count += 1
    updateDailyCount()
    
    let generator = UIImpactFeedbackGenerator(style: UserPreferences.shared.hapticFeedbackStyle)
    generator.prepare()
    generator.impactOccurred()
  }
  
  private func decrementCount() {
    if goldenCount.count > 0 {
      goldenCount.count -= 1
      updateDailyCount()
    }
  }
  
  private func updateDailyCount() {
    let fetchRequest: NSFetchRequest<DailyCount> = DailyCount.fetchRequest()
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@",
                                         today as NSDate, calendar.date(byAdding: .day, value: 1, to: today)! as NSDate)
    do {
      let results = try viewContext.fetch(fetchRequest)
      if let existingCount = results.first {
        existingCount.count = Int32(goldenCount.count)
      } else {
        let dailyCount = DailyCount(context: viewContext)
        dailyCount.date = Date()
        dailyCount.count = Int32(goldenCount.count)
      }
      try viewContext.save()
    } catch {
      print("Error saving/updating count: \(error)")
    }
    
  }
  
  private func loadTodayCount() {
    let fetchRequest: NSFetchRequest<DailyCount> = DailyCount.fetchRequest()
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", today as NSDate, calendar.date(byAdding: .day, value: 1, to: today)! as NSDate)
    do {
      let results = try viewContext.fetch(fetchRequest)
      goldenCount.count = Int(results.first?.count ?? 0)
    } catch {
      print("Error fetching today's count: \(error)")
    }
  }
}
