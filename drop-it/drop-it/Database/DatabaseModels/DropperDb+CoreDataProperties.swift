//
//  DropperDb+CoreDataProperties.swift
//  drop-it
//
//  Created by Ruben Mimoun on 09/01/2022.
//
//

import Foundation
import CoreData


extension DropperDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DropperDb> {
        return NSFetchRequest<DropperDb>(entityName: "DropperDb")
    }

    @NSManaged public var address: UserDb?
    @NSManaged public var bags: NSSet?
    @NSManaged public var user: UserDb?

}

// MARK: Generated accessors for bags
extension DropperDb {

    @objc(addBagsObject:)
    @NSManaged public func addToBags(_ value: BagDb)

    @objc(removeBagsObject:)
    @NSManaged public func removeFromBags(_ value: BagDb)

    @objc(addBags:)
    @NSManaged public func addToBags(_ values: NSSet)

    @objc(removeBags:)
    @NSManaged public func removeFromBags(_ values: NSSet)

}

extension DropperDb : Identifiable {

}
