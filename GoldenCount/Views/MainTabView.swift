//
//  ContentView.swift
//  GoldenCount
//
//  Created by Muugii M. on 1/31/25.
//

import SwiftUI

struct MainTabView: View {
  @State private var selectedTab = 0
  
  var body: some View {
    TabView(selection: $selectedTab) {
      CounterView()
        .tabItem {
          Image(systemName: "pawprint.fill")
          Text("Counter")
        }
        .tag(0)
      
      CalendarView()
        .tabItem {
          Image(systemName: "calendar")
          Text("History")
        }
        .tag(1)
      
      ProfileView()
        .tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }
        .tag(2)
    }
  }
}
