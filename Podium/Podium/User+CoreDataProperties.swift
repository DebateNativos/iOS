//
//  User+CoreDataProperties.swift
//  Podium
//
//  Created by Carlos M Solis on 10/25/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation
import CoreData


extension UserCoreData {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<UserCoreData>(entityName: "UserData") as! NSFetchRequest<NSFetchRequestResult>;
    }

    @NSManaged public var address: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var email: String?
    @NSManaged public var id: Int
    @NSManaged public var idToken: String
    @NSManaged public var idUniversity: Int
    @NSManaged public var lastname: String?
    @NSManaged public var lastname2: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?

}
