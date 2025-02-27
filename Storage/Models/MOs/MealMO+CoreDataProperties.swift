//
//  MealMO+CoreDataProperties.swift
//  Storage
//
//  Created by Dmitry Kononov on 27.02.25.
//
//

import Foundation
import CoreData


extension MealMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealMO> {
        return NSFetchRequest<MealMO>(entityName: "MealMO")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var category: String?
    @NSManaged public var receipt: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var isFavourite: Bool

}

extension MealMO : Identifiable {

}
