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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserData");
    }

    @NSManaged public var address: String?
    @NSManaged public var birthday: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var id: Int
    @NSManaged public var idToken: String
    @NSManaged public var idUniversity: Int64
    @NSManaged public var lastname: String?
    @NSManaged public var lastname2: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?

}
