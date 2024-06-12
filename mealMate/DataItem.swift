//
//  DataItem.swift
//  mealMate
//
//  Created by jessiline imanuela on 06/06/24.
//

import Foundation
import SwiftData

@Model
class DataItem: Identifiable{
    var id: String
    let Title: String
    let Ingredients: String
    let Steps: String
    let Url: String
    var isClicked = false
    
    init(id: String, Title: String, Ingredients: String, Steps: String, Url: String, isClicked: Bool = false) {
        self.id = UUID().uuidString
        self.Title = Title
        self.Ingredients = Ingredients
        self.Steps = Steps
        self.Url =  Url
        self.isClicked = isClicked
    }
}
