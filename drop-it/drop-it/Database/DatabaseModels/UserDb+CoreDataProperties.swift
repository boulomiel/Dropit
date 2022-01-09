//
//  UserDb+CoreDataProperties.swift
//  drop-it
//
//  Created by Ruben Mimoun on 09/01/2022.
//
//

import Foundation
import CoreData


extension UserDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDb> {
        return NSFetchRequest<UserDb>(entityName: "UserDb")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var id: String?
    @NSManaged public var address: AddressDb?
    @NSManaged public var phoneNumber: PhoneNumberDb?

}

extension UserDb : Identifiable {

}
