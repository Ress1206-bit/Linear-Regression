//
//  Graphing.swift
//  Linear-Regression
//
//  Created by Adam Ress on 12/24/23.
//

import SwiftUI

struct Graphing: View {
    
    @State var zoomScale: Int = 1
    @State var xAxis = ""
    @State var yAxis = ""
    
    var points: [[Int]] = [[]]
        
    init(points: [[Int]]) {
        self.points = points
    }
    
    var body: some View {
        VStack{
            Text("Create your own AI Model")
                .font(.title)
                .bold()
                .padding(.top, 10)
            HStack{
                Text("X-Axis:")
                    .padding(.leading, 50)
                TextField("Type here", text: $xAxis)
            }
            HStack{
                Text("Y-Axis:")
                    .padding(.leading, 50)
                TextField("Type here", text: $yAxis)
            }
            ZStack{
                GeometryReader { geometry in
                    ZStack{
                        ZStack{
                            VStack{
                                ForEach(0..<11) { i in
                                    if(i == 11/2){
                                        Rectangle()
                                            .frame(height: 5)
                                            .padding()
                                    }
                                    else{
                                        Rectangle()
                                            .frame(height: 0.5)
                                            .padding()
                                    }
                                    
                                }
                            }
                            
                            HStack{
                                ForEach(0..<11) { i in
                                    if(i == 11/2){
                                        Rectangle()
                                            .frame(width: 5)
                                            .padding()
                                    }
                                    else{
                                        Rectangle()
                                            .frame(width: 0.5)
                                            .padding()
                                    }
                                    
                                }
                            }
                        }
                        .frame(height:geometry.size.height/2)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                        .scaleEffect(0.8)
                    }
                } //graph
                GeometryReader{ geometry in
                    
                    if(points != [[]]){
                        
                        let width:Int = Int(geometry.size.width)
                        let height:Int = Int(geometry.size.height)
                        
                        
                        ForEach(points, id: \.self){ point in
                            
                            let xPosition = (18 + (6 + point[0]) * width)/12 // (144 + (48 + 10PS)X) / 96
                            
                            let yPosition = (6*height - point[1] * width)/12 // (48Y - 10PSX) / 96
                            
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 10, height: 10)
                                .position(x: CGFloat(xPosition), y: CGFloat(yPosition))
                        }
                    }
                } //points
            }
            .frame(height: 350)
            
            Text("Input Values")
            
            HStack{
               // Text("\(xAxis ?? "X")-Values")
            }
            
            Spacer()
        }
            

    }
}

#Preview {
    Graphing(points: [[0, 0], [1, 1], [2, 1], [1, 0], [2, 2]])
}


