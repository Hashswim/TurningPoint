//
//  CoreDataManager.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/08/23.
//

import UIKit
import CoreData

class UserCoreDataManager {
    static var shared: UserCoreDataManager = UserCoreDataManager()

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
    func create(appKey: String, secretKey: String, name: String, favoriteItems: [String], trainingItems: [String]) {
        createUserEntity(appKey: appKey, secretKey: secretKey, name: name, favoriteItems: favoriteItems, trainingItems: trainingItems)
        saveContext()
    }

    private func createUserEntity(appKey: String, secretKey: String, name: String, favoriteItems: [String], trainingItems: [String]) {
        if let entity = userEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(appKey, forKey: "appKey")
            managedObject.setValue(secretKey, forKey: "secretKey")
            managedObject.setValue(UIImage(systemName: "photo.circle.fill")!.pngData(), forKey: "profileImage")
            managedObject.setValue(name, forKey: "name")
            managedObject.setValue(favoriteItems, forKey: "favoriteItems")
            managedObject.setValue(trainingItems, forKey: "trainingItems")
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
    func update(appKey: String, favoriteItems: [String]) {
        let fetchResults = fetchUserEntity()
        if fetchResults.contains(where: { $0.appKey == appKey }) {
            for result in fetchResults where result.appKey == appKey {
                result.favoriteItems = favoriteItems
            }
        } else {
            print("error")
        }
        saveContext()
    }

    func update(appKey: String, trainingItems: [String]) {
        let fetchResults = fetchUserEntity()
        if fetchResults.contains(where: { $0.appKey == appKey }) {
            for result in fetchResults where result.appKey == appKey {
                result.trainingItems = trainingItems
            }
        } else {
            print("error")
        }
        saveContext()
    }

    func update(appKey: String, profileImage: Data) {
        let fetchResults = fetchUserEntity()
        if fetchResults.contains(where: { $0.appKey == appKey }) {
            for result in fetchResults where result.appKey == appKey {
                result.profileImage = profileImage
            }
        } else {
            print("error")
        }
        saveContext()
    }

    // MARK: - DELETE
    func delete() {
        let fetchResults = fetchUserEntity()
        fetchResults.compactMap {
            context.delete($0)
        }
        saveContext()
    }
}
