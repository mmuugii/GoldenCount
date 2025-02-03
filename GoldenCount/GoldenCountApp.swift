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
    @StateObject private var authManager = AuthenticationManager.shared
    
    init() {
        authManager.checkAuthentication()
    }
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                MainTabView()
                    .environment(\.managedObjectContext, goldenCount.container.viewContext)
            } else {
                LoginView()
            }
        }
    }
}
