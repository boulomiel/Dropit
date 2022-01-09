//
//  BagsRepository.swift
//  drop-it
//
//  Created by Ruben Mimoun on 08/01/2022.
//

import Foundation
import CoreData

struct BagsRepository{
    var context : NSManagedObjectContext
    
    init(_ context : NSManagedObjectContext){
        self.context =  context
    }
}

extension BagsRepository : RepositoryDelegate  {
    func create<T>(_ obj: T) where T : DropCodable {
        if let bag = obj as? Bag{
            let bagsDB =  BagDb(context: context)
            bagsDB.id =  bag.id
            bagsDB.name = bag.name
            do{
                try  context.save()
            }catch{
                print("Create bag \(obj)", error)
            }
        }
    }
    
    func update<T>(where: NSPredicate, _ obj: T) where T : DropCodable {}
    
    func remove<T>(_ obj: T) where T : DropCodable {
        if let bag = obj as? Bag{
            let request = BagDb.fetchRequest()
            do{
                let bags =  try context.fetch(request) as NSArray
                let predicate =  NSPredicate(format: "name == %@", bag.name)
                if let bagToRemove =  bags.filtered(using: predicate).first as? BagDb{
                    context.delete(bagToRemove)
                }
                try  context.save()
            }catch{
                print("remove bag \(obj)", error)
            }
        }
    }
    
    func fetchAll<T>() -> [T] where T : DropCodable {
        let request = BagDb.fetchRequest()
        do{
            let bags =  try context.fetch(request)
            return bags.compactMap { bagDb in
                Bag(name: bagDb.name ?? "No Name") as? T
            }
        }catch{
            print("Fecth Bags", error)
            return []
        }
    }
    
    func removeAll(){
        let request = BagDb.fetchRequest()
        do{
            let bags =  try context.fetch(request)
            bags.forEach {
                context.delete($0)
            }
            try context.save()
        }catch{
            print("removeAll Bags", error)
        }
    }
    
    func fetch<T>(where predicate: NSPredicate) -> T? where T : DropCodable {
            let request = BagDb.fetchRequest()
            do{
                let bags =  try context.fetch(request) as NSArray
                if let bagToFind =  bags.filtered(using: predicate).first as? BagDb{
                    return bagToFind as? T
                }
                print("Could not find bag")
                return nil
            }catch{
                print("Could not find bag", error)
                return nil
            }
    }
}
