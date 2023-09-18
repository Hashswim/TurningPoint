//
//  TransactionCoreDataManager.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/09/17.
//

import UIKit
import CoreData

class TransactionCoreDataManager {
    static var shared: TransactionCoreDataManager = TransactionCoreDataManager()

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

    var transactionEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "Transaction", in: context)
    }

    func fetchTransactions() -> [Transaction] {
        do {
            let request = Transaction.fetchRequest()
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    // MARK: - CREATE
    func create(code: String, action: String, count: Int, date: String, name: String, price: Double) {
        createTransactionEntity(code: code, action: action, count: count, date: date, name: name, price: price)
        saveContext()
    }

    private func createTransactionEntity(code: String, action: String, count: Int, date: String, name: String, price: Double) {
        if let entity = transactionEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(code, forKey: "code")
            managedObject.setValue(action, forKey: "action")
            managedObject.setValue(count, forKey: "count")
            managedObject.setValue(date, forKey: "date")
            managedObject.setValue(name, forKey: "name")
            managedObject.setValue(price, forKey: "price")
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
    func readTransactionEntity() -> [Transaction] {
        return fetchTransactionEntity()
    }

    private func fetchTransactionEntity() -> [Transaction] {
        do {
            let request = Transaction.fetchRequest()
            let results = try context.fetch(request)

            return results
        } catch {
            print(error.localizedDescription)
        }

        return []
    }

    // MARK: - UPDATE


    // MARK: - DELETE
    func delete() {
        let fetchResults = fetchTransactionEntity()
        fetchResults.compactMap {
            context.delete($0)
        }
        saveContext()
    }
}

