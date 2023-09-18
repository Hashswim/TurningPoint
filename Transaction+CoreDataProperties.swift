//
//  Transaction+CoreDataProperties.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/09/18.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var action: String?
    @NSManaged public var code: String?
    @NSManaged public var count: Int16
    @NSManaged public var date: String?
    @NSManaged public var investment: Double
    @NSManaged public var name: String?
    @NSManaged public var price: Double

}

extension Transaction : Identifiable {

}
