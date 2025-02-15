//
//  GoldenCount.swift
//  GoldenCount
//
//  Created by Muugii M. on 1/31/25.
//

import Foundation
import CoreData

class GoldenCount: ObservableObject {
  @Published var count: Int = 0
  
  static let shared = GoldenCount()
  let container: NSPersistentContainer
  
  private init() {
    container = NSPersistentContainer(name: "GoldenCount")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
        fatalError("Failed to load Core Data stack: \(error)")
      }
    }
  }
}
