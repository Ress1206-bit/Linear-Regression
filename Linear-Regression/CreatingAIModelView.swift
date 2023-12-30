//
//  CreatingAIModelView.swift
//  Linear-Regression
//
//  Created by Adam Ress on 12/28/23.


import SwiftUI
import PhotosUI

struct CreatingAIModelView: View {
    
    @Environment(\.modelContext) private var context
    
    var xAxis: String?
    var yAxis: String?
    var points: [[Int]]?
    
    @State var name: String = ""
    
    
    @State var newImage: PhotosPickerItem?
    @State var testImage: UIImage?
    
    @State var backgroundType = "Image"
    @State private var selectedColor = Color.red
    
    @State var colorOptions = [
        Color.red,
        Color.green,
        Color.blue,
        Color.orange,
        Color.yellow,
        Color.purple,
        Color.pink,
        Color.gray,
    ]
    
    let backgroundOptions = ["Image", "Color"]
    
    //@FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        Text("Name your model:")
                            .padding(-3)
                            .bold()
                        Spacer()
                    } //Name model Text
                    .font(.largeTitle)
                    
                    HStack{
                        Spacer()
                        TextField("Type here...", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 250)
                            .padding(.bottom, 20)
                        //.focused($isFocused)
                        Spacer()
                    } //Input Text
                    .font(.title)
                    
                    Divider()
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text("Add a background:")
                                .padding(.top, 10)
                                .bold()
                            Spacer()
                        }
                        .font(.largeTitle)
                        
                        Picker("BackgroundType", selection: $backgroundType) {
                            ForEach(backgroundOptions, id: \.self){ type in
                                Text(type)
                                    .padding(.vertical)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 60)
                        .padding(.top, -5)
                        //.disabled(isFocused)
                        
                        if backgroundType == "Image" {
                            PhotosPicker(selection: $newImage, matching: .images) {
                                if let testImage {
                                    Image(uiImage: testImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxHeight: 140)
                                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                        .padding(.horizontal, 30)
                                        .padding(.top, 20)
                                } else {
                                    ZStack{
                                        Rectangle()
                                            .foregroundStyle(.white)
                                        VStack{
                                            Text("Add Photo")
                                                .font(.title)
                                                .padding(.top, 10)
                                            Image(systemName: "photo")
                                                .font(.system(size: 80))
                                                .padding(.bottom, 10)
                                        }
                                        .foregroundStyle(.black)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                                    .padding(.horizontal, 30)
                                    .padding(.top, 20)
                                    .frame(height: 180)
                                    .shadow(radius: 3)
                                }
                            }
                            //.disabled(isFocused)
                            .onChange(of: newImage) { _, _ in
                                Task{
                                    if let newImage {
                                        if let data = try? await newImage.loadTransferable(type: Data.self) {
                                            if let image = UIImage(data: data) {
                                                testImage = image
                                            }
                                        }
                                    }
                                    
                                    newImage = nil
                                }
                            }
                        }
                        
                        if backgroundType == "Color" {
                            
                            HStack{
                                
                                ForEach(colorOptions, id: \.self){ color in
                                    Circle()
                                        .foregroundStyle(color)
                                        .padding(.vertical)
                                        .scaleEffect(selectedColor == color ? 1.4 : 1)
                                        .shadow(radius: 3)
                                        .onTapGesture {
                                            selectedColor = color
                                        }
                                }
                                .padding(.horizontal, 5)
                            }
                            .background(.thinMaterial)
                            .padding()
                            Rectangle()
                                .foregroundStyle(selectedColor)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                                .padding(.horizontal, 30)
                                .padding(.top, 5)
                                .frame(height: 150)
                                .shadow(radius: 5)
                        }
                        
                        Spacer()
                    } // Picker and Image / Color Maker
                    .frame(maxHeight: 400)
                    
                    Divider()
                    
                    Spacer()
                    
                    NavigationLink(destination: HomeView()){
                        ZStack{
                            Rectangle()
                                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                                .frame(height: 100)
                                .padding(25)
                            
                            Text("Create AI Model")
                                .foregroundStyle(.white)
                                .font(.system(size: 35))
                                .shadow(radius: 10)
                        }
                        .onTapGesture {
                            print("Adding")
                            context.insert(AIModelDataItem(name: name, xAxis: xAxis, yAxis: yAxis, points: points, backgroundType: backgroundType, backgroundImage: testImage?.pngData(), backgroundColor: selectedColor.description))
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CreatingAIModelView()
}
        
