//
//  Linear_RegressionApp.swift
//  Linear-Regression
//
//  Created by Adam Ress on 12/19/23.
//

import SwiftUI
import SwiftData

@main
struct Linear_RegressionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: AIModelDataItem.self)
        }
    }
}
