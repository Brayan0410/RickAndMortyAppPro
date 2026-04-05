//
//  CoreDataStack.swift
//  RickAndMortyAppPro
//
//  Created by Eduardo Geovanni Pérez Munguía on 04/04/26.
//

import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()

    let container: NSPersistentContainer

    private init() {

        container = NSPersistentContainer(name: "RickAndMortyAppPro")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
