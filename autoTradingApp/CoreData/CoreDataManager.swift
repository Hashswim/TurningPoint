//
//  CoreDataManager.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/08/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserCoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var userEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "User", in: context)
    }

    // MARK: - CREATE
    func create(accessToken: String, name: String, favoriteItems: [String]) {
        createUserEntity(accessToken: accessToken, name: name, favoriteItems: favoriteItems)
        saveContext()
    }

    private func createUserEntity(accessToken: String, name: String, favoriteItems: [String]) {
        if let entity = userEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(accessToken, forKey: "accessToken")
            managedObject.setValue(name, forKey: "name")
            managedObject.setValue(favoriteItems, forKey: "favoriteItems")
        }
    }

    private func saveContext() {
        if !context.hasChanges {
            return
        }

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - READ
    func readUserEntity() -> [User] {
        return fetchUserEntity()
    }

    private func fetchUserEntity() -> [User] {
        do {
            let request = User.fetchRequest()
            let results = try context.fetch(request)

            return results
        } catch {
            print(error.localizedDescription)
        }

        return []
    }

    // MARK: - UPDATE
    func update(token: String, favoriteItems: [String]) {
        let fetchResults = fetchUserEntity()
        if fetchResults.contains(where: { $0.accessToken == token }) {
            for result in fetchResults where result.accessToken == token {
                result.favoriteItems = favoriteItems
            }
        } else {
//            create(diary: diary)
            print("error")
        }

        saveContext()
    }

    // MARK: - DELETE
    func delete(token: String) {
        let fetchResults = fetchUserEntity()
        guard let diaryEntity = fetchResults.first(where: { $0.accessToken == token }) else {
            return
        }

        context.delete(diaryEntity)
        saveContext()
    }
}
