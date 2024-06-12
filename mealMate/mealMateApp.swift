//
//  mealMateApp.swift
//  mealMate
//
//  Created by jessiline imanuela on 27/05/24.
//

import SwiftUI
import SwiftData

@main
struct mealMateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DataItem.self) 
    }
}
