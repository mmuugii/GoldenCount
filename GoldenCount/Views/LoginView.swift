//
//  LoginView.swift
//  GoldenCount
//
//  Created by Muugii M. on 2/1/25.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
  @ObservedObject private var authManager = AuthenticationManager.shared
  @State private var showError = false
  @State private var errorMessage = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @FocusState private var focusedField: Field?
  
  enum Field {
    case email
    case password
  }
  
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
      
      VStack(spacing: 15) {
        TextField("Email", text: $email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .autocapitalization(.none)
          .keyboardType(.emailAddress)
          .textContentType(.emailAddress)
          .focused($focusedField, equals: .email)
          .submitLabel(.next)
          .onSubmit {
              focusedField = .password
          }
        SecureField("Password", text: $password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .textContentType(.password) // Add this
          .focused($focusedField, equals: .password)
          .submitLabel(.go)
          .onSubmit(signIn)
        
        Button(action: signIn) {
          Text("Sign In")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
      }
      .padding(.horizontal, 40)
      
      Text("Development Build: Any non-empty email/password will work")
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding()
    .onAppear {
      focusedField = .email
    }
    .alert("Sign In Error", isPresented: $showError) {
      Button("OK", role: .cancel) { }
    } message: {
      Text(errorMessage)
    }
  }
  private func signIn() {
    if email.isEmpty || password.isEmpty {
      showError = true
      errorMessage = "Please enter both email and password"
      return
    }
    
    authManager.signInWithTestAccount(email: email, password: password)
  }
}

//            SignInWithAppleButton(
//                onRequest: { request in
//                    request.requestedScopes = [.fullName, .email]
//                },
//                onCompletion: { result in
//                    Task {
//                        do {
//                            try await authManager.signInWithApple()
//                        } catch {
//                            showError = true
//                            errorMessage = error.localizedDescription
//                        }
//                    }
//                }
//            )
//            .frame(height: 45)
//            .padding(.horizontal, 40)
//        }
//        .padding()
//        .alert("Sign In Error", isPresented: $showError) {
//            Button("OK", role: .cancel) { }
//        } message: {
//            Text(errorMessage)
//        }
//    }
// }
