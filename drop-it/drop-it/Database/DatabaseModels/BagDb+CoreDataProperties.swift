//
//  BagDb+CoreDataProperties.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//
//

import Foundation
import CoreData


extension BagDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BagDb> {
        return NSFetchRequest<BagDb>(entityName: "BagDb")
    }

    @NSManaged public var name: String?

}

extension BagDb : Identifiable {

}
