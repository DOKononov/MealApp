//
//  MealsStorage.swift
//  Storage
//
//  Created by Dmitry Kononov on 27.02.25.
//

import Foundation
import CoreData

public final class MealsStorage {
    public init() {}
    
    public func fetch() -> [MealDTO] {
        let request = MealMO.fetchRequest()
        let context = CoreDataService.shared.mainContext
        return  (try? context.fetch(request))?
            .compactMap() {MealDTO(mo: $0)} ?? []
    }
    
    public func create(
        dto: MealDTO,
        completion: @escaping (Bool) -> Void
    ) {
        let context = CoreDataService.shared.backgroundContext
        context.perform {
            let mo = MealMO(context: context)
            mo.apply(dto: dto)
            CoreDataService.shared.save(context: context, completion: completion)
        }
    }
    
}
