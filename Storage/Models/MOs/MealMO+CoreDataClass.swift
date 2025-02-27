//
//  MealMO+CoreDataClass.swift
//  Storage
//
//  Created by Dmitry Kononov on 27.02.25.
//
//

import Foundation
import CoreData

@objc(MealMO)
public class MealMO: NSManagedObject {
    func apply(dto: MealDTO) {
        self.id = dto.id
        self.name = dto.name
        self.category = dto.category
        self.receipt = dto.receipt
        self.imageURL = dto.imageURL
        self.isFavourite = dto.isFavourite
    }
}
