//
//  MealDTO.swift
//  Storage
//
//  Created by Dmitry Kononov on 27.02.25.
//

import Foundation

public struct MealDTO {
   
   public let id: String
   public let name: String
   public let category: String
   public let receipt: String
   public let imageURL: String
   public var isFavourite: Bool
    
    public init(
        id: String,
        name: String,
        category: String,
        receipt: String,
        imageURL: String,
        isFavourite: Bool
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.receipt = receipt
        self.imageURL = imageURL
        self.isFavourite = isFavourite
    }
    
    init?(mo: MealMO) {
        guard let id = mo.id,
              let name = mo.name,
                let category = mo.category,
              let receipt = mo.receipt,
              let imageURL = mo.imageURL
        else { return nil }
        
        self.id = id
        self.name = name
        self.category = category
        self.receipt = receipt
        self.imageURL = imageURL
        self.isFavourite = mo.isFavourite
    }
}
