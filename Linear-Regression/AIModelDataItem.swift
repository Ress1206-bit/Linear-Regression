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
    var image: String?
    var points: [[Int]]?
    
    init(name: String, points: [[Int]], image: String) {
        id = UUID().uuidString
        self.name = name
        self.points = points
        self.image = image
    }
}
