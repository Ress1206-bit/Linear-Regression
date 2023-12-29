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
            Text("My Models")
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("My AI Models")
                }
            Graphing(points: points)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Create New AI Model")
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
