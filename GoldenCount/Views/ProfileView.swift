//
//  ProfileView.swift
//  GoldenCount
//
//  Created by Muugii M. on 1/31/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("username") private var username: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Username", text: $username)
                }
                Section {
                    Button("Sign Out") {
                        // TODO: implement sign out logic
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}
