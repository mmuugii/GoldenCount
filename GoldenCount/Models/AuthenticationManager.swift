//
//  AuthenticationManager.swift
//  GoldenCount
//
//  Created by Muugii M. on 2/1/25.
//

import SwiftUI
import AuthenticationServices

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var userId: String?
    
    static let shared = AuthenticationManager()
    
    func signInWithTestAccount(email: String, password: String) {
        if !email.isEmpty && !password.isEmpty {
            let testUserId = "test_\(email.split(separator: "@").first ?? "")"
            self.userId = testUserId
            UserDefaults.standard.set(testUserId, forKey: "userId")
            isAuthenticated = true
        }
    }
    func signOut() {
        isAuthenticated = false
        userId = nil
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    func checkAuthentication() {
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            self.userId = userId
            isAuthenticated = true
        }
    }
}
//    @MainActor
//    func signInWithApple() async throws {
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        request.requestedScopes = [.fullName, .email]
//        
//        let result = try await withCheckedThrowingContinuation { continuation in
//            let controller = ASAuthorizationController(authorizationRequests: [request])
//            let delegate = SignInDelegate(continuation: continuation)
//            controller.delegate = delegate
//            controller.presentationContextProvider = delegate
//            self.currentSignInDelegate = delegate
//            controller.performRequests()
//        }
//        self.currentSignInDelegate = nil
//        guard let appleIDCredential = result.credential as? ASAuthorizationAppleIDCredential else {
//            throw AuthError.invalidCredential
//        }
//        let userId = appleIDCredential.user
//        self.userId = userId
//        UserDefaults.standard.set(userId, forKey: "userId")
//        
//        isAuthenticated = true
//    }
//    private var currentSignInDelegate: SignInDelegate?
//    
//    func signOut() {
//        isAuthenticated = false
//        userId = nil
//        UserDefaults.standard.removeObject(forKey: "userId")
//    }
//    
//    func checkAuthentication() {
//        if let userId = UserDefaults.standard.string(forKey: "userId") {
//            self.userId = userId
//            isAuthenticated = true
//        }
//    }
//}

//private class SignInDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
//    let continuation: CheckedContinuation<ASAuthorization, Error>
//    
//    init(continuation: CheckedContinuation<ASAuthorization, Error>) {
//        self.continuation = continuation
//        super.init()
//    }
//    
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first(where: { $0.isKeyWindow})
//        else {
//            return UIWindow()
//        }
//        return window
//    }
//    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        Task { @MainActor in
//            continuation.resume(returning: authorization)
//        }
//    }
//    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        Task { @MainActor in
//            continuation.resume(throwing: error)
//        }
//    }
//}
//
//enum AuthError: Error {
//    case invalidCredential
//}
