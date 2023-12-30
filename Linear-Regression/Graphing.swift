//
//  Graphing.swift
//  Linear-Regression
//
//  Created by Adam Ress on 12/24/23.
//

import SwiftUI
import Combine

struct Graphing: View {
    
//    @State var zoomScale: Int = 1
//    @State var finalScale: Double = 0
//    @State var currentScale: Double = 0
    
    @State var xAxis = ""
    @State var yAxis = ""
    
    @State var points: [[Int]] = [[0,0]]
    
    //@State var shownPoints: [[Double]] = [[0,0]]
    
    
//    @FocusState var isFocused1: Bool
//    @FocusState var isFocused2: Bool
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    
                    Text("Create your own AI Model")
                        .font(.title)
                        .bold()
                        .padding(.top, 10)
                    
                    HStack{
                        Text("X-Axis:")
                            .padding(.leading, 30)
                            //.focused($isFocused1)
                        TextField("Type here", text: $xAxis)
                            .textFieldStyle(.roundedBorder)
                            .padding(.trailing, 10)
                        Text("Y-Axis:")
                        //   .padding(.leading, 70)
                            //.focused($isFocused2)
                        TextField("Type here", text: $yAxis)
                            .textFieldStyle(.roundedBorder)
                            .padding(.trailing, 10)
                    } // X and Y axes naming
                    
                    Divider()
                    
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
                                        .foregroundColor(Color(hue: 0.001, saturation: 1.0, brightness: 0.921))
                                        .frame(width: 10, height: 10)
                                        .position(x: CGFloat(xPosition), y: CGFloat(yPosition))
                                }
                            }
                        } //points
                    } //Graph and Points
                    .frame(height: 350)
//                    .gesture(
//                        MagnificationGesture()
//                            .onChanged({ newScale in
//                                currentScale = Double(newScale)
//                                print("finalScale: \(finalScale)")
//                                print("currentScale: \(currentScale)")
//                                print("Sum: \(finalScale + currentScale)")
//                            })
//                            .onEnded({ scale in
//                                finalScale -= currentScale
//                                currentScale = 0
//                                print("End")
//                            })
//                    )
                    
                    Divider()
                    
                    ScrollView(showsIndicators: true) {
                        
                        HStack{
                            if(xAxis == ""){
                                Text("X-Values:")
                                    .padding(.trailing, 20)
                                    .bold()
                            }
                            else{
                                Text("\(xAxis)-Values:")
                                    .padding(.trailing, 20)
                                    .bold()
                            }
                            
                            if(yAxis == ""){
                                Text("Y-Values:")
                                    .padding(.leading, 20)
                                    .bold()
                            }
                            else{
                                Text("\(yAxis)-Values:")
                                    .padding(.leading, 20)
                                    .bold()
                            }
                        } //X-Values and Y-Values Text Boxes
                        
                        ForEach(points.indices, id: \.self){ i in
                            HStack {
                                Spacer()
                                if points.indices.contains(i) && points[i].indices.contains(0) {
                                    TextField("", value: $points[i][0], formatter: NumberFormatter())
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 70, height: 40)
                                        .padding(.trailing, 40)
                                        .keyboardType(.numbersAndPunctuation)
                                        .font(.system(size: 27))
                                } else {
                                    Text("Error")
                                }
                                
                                if points.indices.contains(i) && points[i].indices.contains(1) {
                                    TextField("", value: $points[i][1], formatter: NumberFormatter())
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 70, height: 30)
                                        .padding(.leading, 20)
                                        .keyboardType(.numbersAndPunctuation)
                                        .font(.system(size: 27))
                                } else {
                                    Text("Error")
                                }
                                Spacer()
                            }
                            .padding(.top, 5)
                            
                        }
                        
                        HStack {
                            
                            Button {
                                points.append([0,0])
                            } label: {
                                ZStack{
                                    Rectangle()
                                        .frame(width: 100, height: 40)
                                        .foregroundStyle(Color(hue: 0.338, saturation: 0.389, brightness: 0.647))
                                        .cornerRadius(10)
                                    Text("Add Points")
                                        .foregroundStyle(.white)
                                        .scaleEffect(0.8)
                                }
                            }
                            .padding(.top, 4)
                            
                            Button {
                                if(points.count > 0){
                                    points.removeLast()
                                }
                            } label: {
                                ZStack{
                                    Rectangle()
                                        .frame(width: 100, height: 40)
                                        .foregroundStyle(Color(hue: 1.0, saturation: 0.669, brightness: 0.849))
                                        .cornerRadius(10)
                                    Text("Remove Points")
                                        .foregroundStyle(.white)
                                        .scaleEffect(0.8)
                                }
                            }
                            .padding(.top, 4)
                        }
                        
                    } // Value input
                    .frame(maxHeight: 150)
                    
                    Divider()
                    
                    NavigationLink(destination: CreatingAIModelView(xAxis: xAxis, yAxis: yAxis, points: points)){
                        ZStack{
                            Rectangle()
                                .cornerRadius(15)
                                .padding(.horizontal, 40)
                                .padding(.top, 10)
                                .foregroundColor(Color(hue: 0.001, saturation: 0.588, brightness: 0.971))
                                .shadow(radius: 3)
                                .frame(minHeight: 75, maxHeight: 80)
                            Text("Go to Final Step")
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                                .padding(.top, 7)
                        }
                        .padding(.bottom)
                    }
                    
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .bottom)
//                .onChange(of: points) { _, _ in
//                    shownPoints = points * (finalScale + currentScale)
//                }
            }
        }

  
//        .onTapGesture {
//            isFocused1 = false
//            isFocused2 = false
//        }
            

    }
}

#Preview {
    Graphing()
}
