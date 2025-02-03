//
//  LoginView.swift
//  GoldenCount
//
//  Created by Muugii M. on 2/1/25.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @StateObject private var authManager = AuthenticationManager.shared
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "pawprint.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.orange)
            
            Text("Golden Count")
                .font(.largeTitle)
                .bold()
            
            Text("Track your daily Golden Retriever encounters!")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    Task {
                        do {
                            try await authManager.signInWithApple()
                        } catch {
                            showError = true
                            errorMessage = error.localizedDescription
                        }
                    }
                }
            )
            .frame(height: 45)
            .padding(.horizontal, 40)
        }
        .padding()
        .alert("Sign In Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}
