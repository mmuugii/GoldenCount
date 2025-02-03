//
//  ProfileView.swift
//  GoldenCount
//
//  Created by Muugii M. on 1/31/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var authManager = AuthenticationManager.shared
    @AppStorage("username") private var username: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Username", text: $username)
                    if let userId = authManager.userId {
                        Text("User ID: \(userId)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Section {
                    Button("Sign Out") {
                        authManager.signOut()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Profile")
        }
    }
}
