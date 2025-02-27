//
//  CoreDataService.swift
//  Storage
//
//  Created by Dmitry Kononov on 27.02.25.
//

import Foundation
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    private init() {}
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
     var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    private var persistentContainer: NSPersistentContainer {
        let modelName = "MealsDB"
        let bundle = Bundle(for: CoreDataService.self)
        
        guard
            let modelURL = bundle.url(forResource: modelName, withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else {
            fatalError("[CoreDataService] Cannot find data model")
        }
        
        let container = NSPersistentContainer(
            name: modelName,
            managedObjectModel: managedObjectModel
        )
        container.loadPersistentStores { storeDesk, error in
            if let error {
                fatalError("[CoreDataService] loading persistent stores failed: \(error.localizedDescription)")
            }
        }
        return container
    }
    
    func save(
        context: NSManagedObjectContext,
        completion: @escaping (Bool)-> Void
    ) {
        if context.hasChanges {
            do {
                try context.save()
                completion(true)
            } catch {
                print("[CoreDataService] Can not save context: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
