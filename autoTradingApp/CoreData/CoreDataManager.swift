//
//  CoreDataManager.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/08/23.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()

    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext

    let modelName: String = "User"

    func getUsers() -> [User] {
        var models: [User] = [User]()

        if let context = context {
            let fetchRequest: NSFetchRequest<NSManagedObject>
                = NSFetchRequest<NSManagedObject>(entityName: modelName)

            do {
                if let fetchResult: [User] = try context.fetch(fetchRequest) as? [User] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }

    func saveUser(accessToken: String, favoriteItems: [String], name: String, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {

            if let user: User = NSManagedObject(entity: entity, insertInto: context) as? User {
                user.accessToken = accessToken
                user.name = name
                user.favoriteItems = favoriteItems

                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }

    func deleteUser(token: String, onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(token: token)

        do {
            if let results: [User] = try context?.fetch(fetchRequest) as? [User] {
                if results.count != 0 {
                    context?.delete(results[0])
                }
            }
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
            onSuccess(false)
        }

        contextSave { success in
            onSuccess(success)
        }
    }
}

extension CoreDataManager {
    fileprivate func filteredRequest(token: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "accessToken = %@", token)
        return fetchRequest
    }

    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}
