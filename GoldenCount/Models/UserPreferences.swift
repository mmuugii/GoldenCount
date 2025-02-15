//
//  UserPreferences.swift
//  GoldenCount
//
//  Created by Muugii M. on 2/15/25.
//
import Foundation
import UIKit

class UserPreferences: ObservableObject {
  static let shared = UserPreferences()
  @Published var hapticFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle {
    didSet {
      UserDefaults.standard.set(hapticFeedbackStyle.rawValue, forKey: "hapticFeedbackStyle")
    }
  }
  
  @Published var displayName: String {
    didSet {
      UserDefaults.standard.set(displayName, forKey: "displayName")
    }
  }
  
  init() {
    let savedStyle = UserDefaults.standard.integer(forKey: "hapticFeedbackStyle")
    self.hapticFeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: savedStyle) ?? .medium
    self.displayName = UserDefaults.standard.string(forKey: "displayName") ?? ""
  }
  
  func updateHapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
    hapticFeedbackStyle = style
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.prepare()
    generator.impactOccurred()
  }
}
