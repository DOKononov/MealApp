//
//  MealToDTOMapper.swift
//  MealApp
//
//  Created by Dmitry Kononov on 27.02.25.
//

import Foundation
import Storage

final class MealToDTOMapper {
    private init() {}
    
    static func map(from meal: Meal) -> MealDTO {
        return MealDTO(
            id: meal.id,
            name: meal.name,
            category: meal.category,
            receipt: meal.receipt,
            imageURL: meal.imageUrl,
            isFavourite: true
        )
    }
}
