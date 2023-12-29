//
//  HomeView.swift
//  Linear-Regression
//
//  Created by Adam Ress on 12/28/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Query private var models: [AIModelDataItem]
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("My AI Models")
                    .font(.largeTitle)
                    .padding(.top)
                    .bold()
                
                Divider()
                
                ForEach(models){ model in
                    Text(model.name ?? "")
                }
                
                NavigationLink {
                    Graphing()
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.gray)
                            .cornerRadius(30)
                            .frame(height: 90)
                            .padding(25)
                        Image(systemName: "plus")
                            .foregroundColor(Color(hue: 1.0, saturation: 0.007, brightness: 0.935))
                            .scaleEffect(3)
                    }
                }

                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
