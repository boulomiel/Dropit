//
//  UserDb+CoreDataProperties.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//
//

import Foundation
import CoreData


extension UserDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDb> {
        return NSFetchRequest<UserDb>(entityName: "UserDb")
    }
    @NSManaged public var fullName: String?
    @NSManaged public var phoneNumber: PhoneNumberDb?
    @NSManaged public var address: AddressDb?


}

extension UserDb : Identifiable {

}
