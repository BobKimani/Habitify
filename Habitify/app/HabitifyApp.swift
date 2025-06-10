//
//  HabitifyApp.swift
//  Habitify
//
//  Created by Tevin Omondi on 05/06/2025.
//

import SwiftUI

@main
struct HabitifyApp: App {
    @State private var isActive = false
    
    var body: some Scene {
        WindowGroup {
            WelcomeView(isActive: $isActive)
//            BottomNavView()
        }
    }
}

