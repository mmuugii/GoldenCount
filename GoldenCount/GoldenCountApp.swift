//
//  GoldenCountApp.swift
//  GoldenCount
//
//  Created by Muugii M. on 1/31/25.
//

import SwiftUI

@main
struct GoldenCountApp: App {
    let goldenCount = GoldenCount.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, goldenCount.container.viewContext)
        }
    }
}
