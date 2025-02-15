//
//  ProfileView.swift
//  GoldenCount
//
//  Created by Muugii M. on 1/31/25.
//

import SwiftUI

struct ProfileView: View {
  @StateObject private var authManager = AuthenticationManager.shared
  @StateObject private var preferences = UserPreferences.shared
  @State private var showingSignOutAlert = false
  @State private var isEditingName = false
  @State private var tempDisplayName: String = ""
  
  var body: some View {
    NavigationStack {
      Form {
        // Profile Section
        Section {
          HStack(spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
              .resizable()
              .frame(width: 60, height: 60)
              .foregroundColor(.orange)
            VStack(alignment: .leading, spacing: 4) {
              if let email = authManager.userEmail {
                Text(email)
                  .font(.title3)
              }
              if isEditingName {
                TextField("Display Name", text: $tempDisplayName)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .onSubmit {
                    preferences.displayName = tempDisplayName
                    isEditingName = false
                  }
              } else {
                Text(preferences.displayName.isEmpty ? "Add display name": preferences.displayName)
                  .font(.subheadline)
                  .foregroundColor(preferences.displayName.isEmpty ? .secondary : .primary)
              }
            }
          }
          .padding(.vertical, 8)
          .onTapGesture {
            tempDisplayName = preferences.displayName
            isEditingName = true
          }
        }
        .listRowBackground(Color.clear)
        
        Section(header: Text("Account")) {
          if let provider = authManager.authProvider {
            Label(provider, systemImage: "shield.lefthalf.filled")
          }
          if let uid = authManager.userId {
            VStack(alignment: .leading) {
              Text("User ID")
                .font(.caption)
                .foregroundColor(.secondary)
              Text(uid)
                .font(.caption)
                .textSelection(.enabled)
            }
          }
        }
        
        Section {
          Button(role: .destructive) {
            showingSignOutAlert = true
          } label: {
            HStack {
              Spacer()
              Text("Sign Out")
              Spacer()
            }
          }
        }
      }
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
      .alert("Sign Out", isPresented: $showingSignOutAlert) {
        Button("Cancel", role: .cancel) {}
        Button("Sign Out", role: .destructive) {
          authManager.signOut()
        }
      } message: {
        Text("Are you sure you want to sign out?")
      }
    }
  }
}
