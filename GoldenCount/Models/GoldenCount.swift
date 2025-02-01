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
    @Published var date: Date = Date()
    
    static let shared = GoldenCount()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "GoldenCount")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
