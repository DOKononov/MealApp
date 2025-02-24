//
//  Meal.swift
//  MealApp
//
//  Created by Dmitry Kononov on 19.02.25.
//

import Foundation

struct Meal: Decodable {
    let id: String
    let name: String
    let category: String
    let receipt: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case receipt = "strInstructions"
        case imageUrl = "strMealThumb"
    }
}

struct MealResponse: Decodable {
    var meals: [Meal]?
}
