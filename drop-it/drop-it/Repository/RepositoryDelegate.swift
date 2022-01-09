//
//  RepositoryDelegate.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//

import Foundation
import CoreData

protocol RepositoryDelegate {
    func create<T : DropCodable>(_ obj : T)
    func update<T : DropCodable>(where: NSPredicate, _ obj : T)
    func removeAll()
    func fetch<T : DropCodable>(where : NSPredicate) -> T?
    func fetchAll<T : DropCodable>()-> [T]
}
