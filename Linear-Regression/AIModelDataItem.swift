//
//  AIModelDataItem.swift
//  Linear-Regression
//
//  Created by Adam Ress on 12/27/23.
//

import Foundation
import SwiftData

@Model
class AIModelDataItem: Identifiable {
    var id: String
    var name: String?
    var xAxis: String?
    var yAxis: String?
    //var image: String?
    var points: [[Int]]?
    var backgroundType: String?
    var backgroundImage: Data?
    var backgroundColor: String?
    
    init(name: String? = nil, xAxis: String? = nil, yAxis: String? = nil, points: [[Int]]? = nil, backgroundType: String? = nil, backgroundImage: Data? = nil, backgroundColor: String? = nil) {
        id = UUID().uuidString
        self.name = name
        self.points = points
        self.backgroundType = backgroundType
        self.backgroundImage = backgroundImage
        self.backgroundColor = backgroundColor
    }
}
