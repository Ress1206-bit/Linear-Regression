//
//  ContentView.swift
//  Linear-Regression
//
//  Created by Adam Ress on 12/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    var points: [[Int]] = [[0,0],[0,0]]//[[0, 0], [1, 1], [2, 1], [1, 0], [2, 2]]
    
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("My AI Models")
                }
            Text("Info")
                .tabItem {
                    Image(systemName: "questionmark.square")
                    Text("How it works")
                }
        }
    }
}

#Preview {
    ContentView()
}
