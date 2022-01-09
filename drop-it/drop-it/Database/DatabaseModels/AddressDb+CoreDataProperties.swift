//
//  AddressDb+CoreDataProperties.swift
//  drop-it
//
//  Created by Ruben Mimoun on 09/01/2022.
//
//

import Foundation
import CoreData


extension AddressDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressDb> {
        return NSFetchRequest<AddressDb>(entityName: "AddressDb")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var streetAddress: String?
    @NSManaged public var id: String?
    @NSManaged public var ofUser: UserDb?

}

extension AddressDb : Identifiable {

}
