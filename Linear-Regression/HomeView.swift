//
//  HomeView.swift
//  Linear-Regression
//
//  Created by Adam Ress on 12/28/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var context
    
    
    
    @Query private var models: [AIModelDataItem]
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("My AI Models")
                    .font(.largeTitle)
                    .padding(.top)
                    .bold()
                
                Divider()

                List(models){ model in
                    if model.backgroundType == "Image" {
                        let image = UIImage(data: model.backgroundImage ?? Data()) ?? UIImage()
                        
                        ZStack{
                            Image(uiImage: image)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                .scaledToFill()
                                .frame(height: 90)
                                //.padding(25)
                                .shadow(radius: 3)
                            Text(model.name ?? "My AI Model")
                                .shadow(radius: 10)
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .swipeActions {
                            Button(action: {
                                context.delete(model)
                            }, label: {
                                Text("Delete")
                            })
                        }
                        .tint(Color.red)
                    }
                    else if model.backgroundType == "Color" {
                        ZStack{
                            Rectangle()
                                .foregroundColor(getColor(selectedColor: model.backgroundColor ?? "red"))
                                .cornerRadius(20)
                                .frame(height: 90)
                              //  .padding(25)
                                .shadow(radius: 3)
                            Text(model.name ?? "My AI Model")
                                .shadow(radius: 10)
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .swipeActions {
                            Button(action: {
                                context.delete(model)
                            }, label: {
                                Text("Delete")
                            })
                        }
                        .tint(Color.red)
                        
                    }
                }
                
                Divider()

                NavigationLink {
                    Graphing()
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.gray)
                            .cornerRadius(20)
                            .frame(height: 90)
                            .padding(.horizontal, 25)
                        Image(systemName: "plus")
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.937))
                            .font(.system(size: 70))
                    }
                }
                
                Divider()
                
                Spacer()
            }
        }
    }
    
    func getColor(selectedColor: String) -> Color {
        if selectedColor == "red"{
            return Color.red
        }
        else if selectedColor == "green"{
            return Color.green
        }
        else if selectedColor == "blue"{
            return Color.blue
        }
        else if selectedColor == "orange"{
            return Color.orange
        }
        else if selectedColor == "yellow"{
            return Color.yellow
        }
        else if selectedColor == "purple"{
            return Color.purple
        }
        else if selectedColor == "pink"{
            return Color.pink
        }
        else if selectedColor == "gray"{
            return Color.gray
        }
        
        return Color.white
    }
}

#Preview {
    HomeView()
}
