//
//  User+CoreDataProperties.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/08/29.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var accessToken: String?
    @NSManaged public var favoriteItems: [String]?
    @NSManaged public var name: String?

}

extension User : Identifiable {

}
