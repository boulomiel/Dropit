//
//  PhoneNumberDb+CoreDataProperties.swift
//  drop-it
//
//  Created by Ruben Mimoun on 09/01/2022.
//
//

import Foundation
import CoreData


extension PhoneNumberDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneNumberDb> {
        return NSFetchRequest<PhoneNumberDb>(entityName: "PhoneNumberDb")
    }

    @NSManaged public var countryCode: Int32
    @NSManaged public var number: String?
    @NSManaged public var ofUser: UserDb?

}
