//
//  RecipeData.swift
//  SporkApp-v3
//
//  Created by Adam Belouad on 12/18/23.
//

import SwiftUI

import SwiftUI

class RecipeData: ObservableObject {
    
    static let shared = RecipeData()

    let timeValues = ["any", "5 min", "10 min", "25 min", "45 min", "1 hr +"]
    @Published var selectedTimeValue: String = "any"
    
    @Published var ingredients: [String] = []
    @Published var newIngredient: String = ""
    
    let servesValues = ["any", "1", "2-4", "5-8", "8+"]
    @Published var selectedServesValue: String = "any"
    
    let dietValues = [" none ", " vegiterian ", " gluten-free ", " vegan ", " keto "]
    @Published var selectedDietValues: String = "any"

    
}

