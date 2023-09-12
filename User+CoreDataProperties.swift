//
//  User+CoreDataProperties.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/08/30.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var favoriteItems: [String]?
    @NSManaged public var trainingItems: [String]?
    @NSManaged public var name: String?
    @NSManaged public var appKey: String?
    @NSManaged public var secretKey: String?
    @NSManaged public var profileImage: Data?

}

extension User : Identifiable {

}
